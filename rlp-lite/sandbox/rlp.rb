

PRIMITIVE_PREFIX_OFFSET = 0x80    # The RLP primitive type offset (dec. 128).
LIST_PREFIX_OFFSET      = 0xc0    # The RLP array type offset (dec. 192).

def rlp_encode( input )
    if input.instance_of?( String )
        if input.length == 1 && input.ord < PRIMITIVE_PREFIX_OFFSET
           input
        else
           encode_length( input.length, PRIMITIVE_PREFIX_OFFSET ) + input
        end
    elsif input.instance_of?( Array )
        output = ''
        input.each do |item|
           output += rlp_encode( item )
        end
        encode_length( output.length, LIST_PREFIX_OFFSET ) + output
    else
         raise ArgumentError, "type error"
    end
end

def encode_length( l, offset )
    if l < 56
         (l + offset).chr
    elsif l < 256**8    ## 256**8 = 18446744073709551616
         bl = to_binary( l )
         (bl.length + offset + 55).chr + bl
    else
         raise ArgumentError, "input too long"
    end
end

def to_binary(x)
   x == 0 ? '' : to_binary( x / 256 ) + (x % 256).chr
end




pp rlp_encode( "cat" )
#=> "\x83cat"

pp rlp_encode( ["cat", "", []] )
#=> "\xC6\x83cat\x80\xC0"

pp rlp_encode( "Lorem ipsum dolor sit amet, consectetur adipisicing elit" )
#=> "\xB88Lorem ipsum dolor sit amet, consectetur adipisicing elit"

# the encoded integer 0 ("\x00")
pp rlp_encode( "\x00".b )
#=> "\x00"

# the encoded integer 15 ("\x0f")
pp rlp_encode( "\x0f".b )
#=> "\x0F"

# the encoded integer 1024 ("\x04\x00")
pp rlp_encode( "\x04\x00".b )
#=> "\x82\x04\x00"




def rlp_decode( input, output=[], level=0 )
  puts "#{'-'*level}input >#{input}< (#{input.length}) @ level #{level}"
  return output[0]    if input.length == 0

  offset, dataLen, type = decode_length( input )
  puts "#{'-'*level}  offset=#{offset}, dataLen=#{dataLen}, type=#{type}"

  if type == String
      output << input[ offset, dataLen ]
  elsif type == Array
      list = []
      rlp_decode(  input[ offset, dataLen], list, level+1 )
      output << list
  else
      raise ArgumentError, "type error"
  end

  rlp_decode(  input[ (offset + dataLen)..-1], output, level )
end


def decode_length( input )
  length = input.length

  raise ArgumentError, "input is null"   if length == 0

  prefix = input[0].ord
  if prefix <= 0x7f
    [0, 1, String]
  elsif prefix <= 0xb7 && length > prefix - 0x80
    strLen = prefix - 0x80
    [1, strLen, String]
  elsif prefix <= 0xbf && length > prefix - 0xb7 && length > prefix - 0xb7 + to_integer( input[1, prefix - 0xb7] )
    lenOfStrLen = prefix - 0xb7
    strLen = to_integer( input[1, lenOfStrLen] )
    [1 + lenOfStrLen, strLen, String]
  elsif prefix <= 0xf7 && length > prefix - 0xc0
    listLen = prefix - 0xc0
    [1, listLen, Array]
  elsif prefix <= 0xff && length > prefix - 0xf7 && length > prefix - 0xf7 + to_integer( input[1, prefix - 0xf7])
    lenOfListLen = prefix - 0xf7
    listLen = to_integer( input[1, lenOfListLen] )
    [1 + lenOfListLen, listLen, Array]
  else
    raise ArgumentError, "input don't conform RLP encoding form"
  end
end


def to_integer( b )
  length = b.length
  if length == 0
      raise ArgumentError, "input is null"
  elsif length == 1
      b[0].ord
  else
      b[-1].ord + to_integer( b[0, length-1] ) * 256
  end
end

pp to_integer( "bbb" )
pp to_integer( "bbbcceeff" )


pp rlp_decode( "\x83cat".b )

pp rlp_decode( "\xB88Lorem ipsum dolor sit amet, consectetur adipisicing elit".b )

pp rlp_decode( "\x00".b )

pp rlp_decode( "\x0F".b )

pp rlp_decode( "\x82\x04\x00".b )


pp rlp_decode( "\xC6\x83cat\x80\xC0".b )

obj = ["cat", "", ["dog", [[], ""]]]
pp obj
encoded =  rlp_encode( obj )
pp encoded

pp rlp_decode( encoded )


puts "bye"