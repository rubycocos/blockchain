
module ABI
  ##
  # Contract ABI encoding and decoding.
  #
  # @see https://github.com/ethereum/wiki/wiki/Ethereum-Contract-ABI
  #

  class EncodingError < StandardError; end
  class DecodingError < StandardError; end
  class ValueError < StandardError; end

  class ValueOutOfBounds < ValueError; end



class Encoder

    ##
    # Encodes multiple arguments using the head/tail mechanism.
    #     returns binary string (with BINARY / ASCII_8BIT encoding)
    #
    def encode( types, args )
      ## enforce args.size and types.size must match - why? why not?
      raise ArgumentError, "Wrong number of args: found #{args.size}, expecting #{types.size}" unless args.size == types.size


      ## for convenience check if types is a String
      ##   otherwise assume ABI::Type already
      types = types.map { |type| type.is_a?( Type ) ? type : Type.parse( type ) }

      ## todo/check:  use args.map (instead of types)
      ##                 might allow encoding less args than types?  - why? why not?
      head_size = types
                    .map {|type| type.size || 32 }
                    .sum

      head, tail = ''.b, ''.b    ## note: use string buffer with BINARY / ASCII_8BIT encoding!!!
      types.each_with_index do |type, i|
        if type.dynamic?
          head += encode_uint256( head_size + tail.size )
          tail += encode_type( type, args[i] )
        else
          head += encode_type( type, args[i] )
        end
      end

      head + tail
    end

    ##
    # Encodes a single value (static or dynamic).
    #
    # @param type [ABI::Type] value type
    # @param arg [Object] value
    #
    # @return [String] encoded bytes
    #
    def encode_type( type, arg )
      if type.is_a?( Tuple )
         encode_tuple( type, arg )
      elsif type.is_a?( Array ) || type.is_a?( FixedArray )
         if type.dynamic?
           encode_dynamic_array( type, arg )
         else
           encode_static_array( type, arg )
         end
      else  # assume primitive type
         encode_primitive_type( type, arg )
      end
    end


   def encode_dynamic_array( type, args )
    raise ArgumentError, "arg must be an array" unless args.is_a?(::Array)

        head, tail = ''.b, ''.b    ## note: use string buffer with BINARY / ASCII_8BIT encoding!!!

        if type.is_a?( Array )  ## dynamic array
          head += encode_uint256( args.size )
        else  ## fixed array
          raise ArgumentError, "Wrong array size: found #{args.size}, expecting #{type.dim}" unless args.size == type.dim
        end

        subtype = type.subtype
        args.each do |arg|
          if subtype.dynamic?
            head += encode_uint256( 32*args.size + tail.size )
            tail += encode_type( subtype, arg )
          else
            head += encode_type( subtype, arg )
          end
        end
        head + tail
   end


   def encode_static_array( type, args )
      raise ArgumentError, "arg must be an array" unless args.is_a?(::Array)
      raise ArgumentError, "Wrong array size: found #{args.size}, expecting #{type.dim}" unless args.size == type.dim

      args.map {|arg| encode_type( type.subtype, arg ) }.join
   end


   ##
   ##  todo/check:  if static tuple gets encoded different
   ##                   without offset  (head/tail)

   def encode_tuple( tuple, args )
    raise ArgumentError, "arg must be an array" unless args.is_a?(::Array)
    raise ArgumentError, "Wrong array size (for tuple): found #{args.size}, expecting #{tuple.type.size} tuple elements" unless args.size == tuple.types.size

       head_size =  tuple.types
                     .map {|type| type.size || 32 }
                     .sum

        head, tail = ''.b, ''.b    ## note: use string buffer with BINARY / ASCII_8BIT encoding!!!
        tuple.types.each_with_index do |type, i|
          if type.dynamic?
            head += encode_uint256( head_size + tail.size )
            tail += encode_type( type, args[i] )
          else
            head += encode_type( type, args[i] )
          end
        end

       head + tail
   end



    def encode_primitive_type( type, arg )
      case type
      when Uint
        ## note: for now size in  bits always required
        encode_uint( arg, type.bits )
      when Int
        ## note: for now size in  bits always required
        encode_int( arg, type.bits )
      when Bool
        encode_bool( arg )
      when String
        encode_string( arg )
      when FixedBytes
        encode_bytes( arg, type.length )
      when Bytes
        encode_bytes( arg )
      when Address
        encode_address( arg )
      else
        raise EncodingError, "Unhandled type: #{type.class.name} #{type.format}"
      end
    end



    def encode_bool( arg )
      ## raise EncodingError or ArgumentError - why? why not?
      raise ArgumentError, "arg is not bool: #{arg}" unless arg.is_a?(TrueClass) || arg.is_a?(FalseClass)
      lpad( arg ? BYTE_ONE : BYTE_ZERO )   ## was  lpad_int( arg ? 1 : 0 )
    end


    def encode_uint256( arg ) encode_uint( arg, 256 ); end
    def encode_uint( arg, bits )
      ## raise EncodingError or ArgumentError - why? why not?
      raise ArgumentError, "arg is not integer: #{arg}" unless arg.is_a?(Integer)
      raise ValueOutOfBounds, arg   unless arg >= 0 && arg < 2**bits
      lpad_int( arg )
    end

    def encode_int( arg, bits )
      ## raise EncodingError or ArgumentError - why? why not?
      raise ArgumentError, "arg is not integer: #{arg}" unless arg.is_a?(Integer)
      raise ValueOutOfBounds, arg   unless arg >= -2**(bits-1) && arg < 2**(bits-1)
      lpad_int( arg % 2**bits )
    end


    def encode_string( arg )
      ## raise EncodingError or ArgumentError - why? why not?
      raise EncodingError, "Expecting string: #{arg}" unless arg.is_a?(::String)
      arg = arg.b   if arg.encoding != Encoding::BINARY    ## was: name == 'UTF-8'

      raise ValueOutOfBounds, "Integer invalid or out of range: #{arg.size}" if arg.size > UINT_MAX
      size  =  lpad_int( arg.size )
      value =  rpad( arg, ceil32(arg.size) )
      size + value
    end


    def encode_bytes( arg, length=nil )
      ## raise EncodingError or ArgumentError - why? why not?
      raise EncodingError, "Expecting string: #{arg}" unless arg.is_a?(::String)
      arg = arg.b    if arg.encoding != Encoding::BINARY

      if length # fixed length type
        raise ValueOutOfBounds, "invalid bytes length #{length}" if arg.size > length
        raise ValueOutOfBounds, "invalid bytes length #{length}" if length < 0 || length > 32
        rpad( arg )
      else  # variable length type  (if length is nil)
        raise ValueOutOfBounds, "Integer invalid or out of range: #{arg.size}" if arg.size > UINT_MAX
        size =  lpad_int( arg.size )
        value = rpad( arg, ceil32(arg.size) )
        size + value
      end
    end


    def encode_address( arg )
      if arg.is_a?( Integer )
        lpad_int( arg )
      elsif arg.size == 20
        ## note: make sure encoding is always binary!!!
        arg = arg.b    if arg.encoding != Encoding::BINARY
        lpad( arg )
      elsif arg.size == 40
        lpad_hex( arg )
      elsif arg.size == 42 && arg[0,2] == '0x'   ## todo/fix: allow 0X too - why? why not?
        lpad_hex( arg[2..-1] )
      else
        raise EncodingError, "Could not parse address: #{arg}"
      end
    end



###########
#  encoding helpers / utils
#    with "hard-coded" fill symbol as BYTE_ZERO

def rpad( bin, l=32 )    ## note: same as builtin String#ljust !!!
  # note: default l word is 32 bytes
  return bin  if bin.size >= l
  bin + BYTE_ZERO * (l - bin.size)
end


## rename to lpad32 or such - why? why not?
def lpad( bin )    ## note: same as builtin String#rjust !!!
  l=32   # note: default l word is 32 bytes
  return bin  if bin.size >= l
  BYTE_ZERO * (l - bin.size) + bin
end

## rename to lpad32_int or such - why? why not?
def lpad_int( n )
  raise ArgumentError, "Integer invalid or out of range: #{n}" unless n.is_a?(Integer) && n >= 0 && n <= UINT_MAX
  hex = n.to_s(16)
  hex = '0'+hex    if hex.size.odd?
  bin = [hex].pack('H*')

  lpad( bin )
end

## rename to lpad32_hex or such - why? why not?
def lpad_hex( hex )
  raise TypeError, "Value must be a string"  unless hex.is_a?( ::String )
  raise TypeError, 'Non-hexadecimal digit found' unless hex =~ /\A[0-9a-fA-F]*\z/
  bin = [hex].pack('H*')

  lpad( bin )
end



def ceil32(x)
  x % 32 == 0 ? x : (x + 32 - x%32)
end

end # class Encoder
end  # module ABI

