
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
    #
    def encode( types, args )
      ## for convenience check if types is a String
      ##   otherwise assume ABI::Type already
      types = types.map { |type| type.is_a?( Type ) ? type : Type.parse( type ) }

      ## todo/check:  use args.map (instead of types)
      ##                 might allow encoding less args than types?  - why? why not?
      head_size = types
                    .map {|type| type.size || 32 }
                    .sum

      head, tail = '', ''
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
      ## case 1)  string or bytes (note:are dynamic too!!! most go first)
      ##  use type == Type.new( 'string', nil, [] ) - same as Type.new('string'))
      ##   or type == Type.new( 'bytes', nil, [] )  - same as Type.new('bytes')
      ##   - why? why not?
      if type.base == 'string' && type.sub.nil? && type.dims.empty?
        encode_string( arg )
      elsif type.base == 'bytes' && type.sub.nil? && type.dims.empty?
         encode_bytes( arg )
      elsif type.base == 'tuple' && type.dims.empty?
         encode_tuple( type, arg )
      elsif type.dynamic?
         encode_dynamic_array( type, arg )
      else   # assume  static type
        if type.dims.empty?
          encode_primitive_type( type, arg )
        else
          encode_static_array( type, arg )
        end
      end
    end


   def encode_dynamic_array( type, args )
    raise ArgumentError, "arg must be an array" unless args.is_a?(Array)

        head, tail = '', ''

        if type.dims.last == -1
          head += encode_uint256( args.size )
        else
          raise ArgumentError, "Wrong array size: found #{args.size}, expecting #{type.dims.last}" unless args.size == type.dims.last
        end

        # dim = type.dims.last
        # dim = args.size     if dim  == -1

        sub_type = type.subtype
        args.each do |arg|
          if sub_type.dynamic?
            head += encode_uint256( 32*args.size + tail.size )
            tail += encode_type( sub_type, arg )
          else
            head += encode_type( sub_type, arg )
          end
        end
        head + tail
   end


   def encode_static_array( type, args )
      raise ArgumentError, "arg must be an array" unless args.is_a?(Array)
      raise ArgumentError, "Wrong array size: found #{args.size}, expecting #{type.dims.last}" unless args.size == type.dims.last

      args.map {|arg| encode_type( type.subtype, arg ) }.join
   end


   ##
   ##  todo/check:  if static tuple gets encoded different
   ##                   without offset  (head/tail)

   def encode_tuple( tuple, args )
    raise ArgumentError, "arg must be an array" unless args.is_a?(Array)
    raise ArgumentError, "Wrong array size (for tuple): found #{args.size}, expecting #{tuple.type.size} tuple elements" unless args.size == tuple.types.size

       head_size =  tuple.types
                     .map {|type| type.size || 32 }
                     .sum

        head, tail = '', ''
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
      case type.base
      when 'uint'
        ## note: for now size in  bits always required
        encode_uint( arg, type.sub )
      when 'int'
        ## note: for now size in  bits always required
        encode_int( arg, type.sub )
      when 'bool'
        encode_bool( arg )
      when 'string'
        encode_string( arg )
      when 'bytes'
        ## note: if no length/size in bytes than
        #          bytes  is dynamic otherweise
        #          bytes1, bytes2, .. bytes32 is fixed
        encode_bytes( arg, type.sub )
      when 'address'
        encode_address( arg )
      else
        raise EncodingError, "Unhandled type: #{type.base} #{type.sub}"
      end
    end



    def encode_bool( arg )
      raise ArgumentError, "arg is not bool: #{arg}" unless arg.is_a?(TrueClass) || arg.is_a?(FalseClass)
      lpad_int( arg ? 1 : 0 )
    end


    def encode_uint256( arg ) encode_uint( arg, 256 ); end
    def encode_uint( arg, bits )
      raise ArgumentError, "arg is not integer: #{arg}" unless arg.is_a?(Integer)
      raise ValueOutOfBounds, arg   unless arg >= 0 && arg < 2**bits
      lpad_int( arg )
    end

    def encode_int( arg, bits )
      raise ArgumentError, "arg is not integer: #{arg}" unless arg.is_a?(Integer)
      raise ValueOutOfBounds, arg   unless arg >= -2**(bits-1) && arg < 2**(bits-1)
      lpad_int( arg % 2**bits )
    end


    def encode_string( arg )
      if arg.encoding == Encoding::UTF_8    ## was: name == 'UTF-8'
        arg = arg.b
      else
        begin
          arg.unpack('U*')
        rescue ArgumentError
          raise ValueError, "string must be UTF-8 encoded"
        end
      end

      raise ValueOutOfBounds, "Integer invalid or out of range: #{arg.size}" if arg.size > UINT_MAX
      size  =  lpad_int( arg.size )
      value =  rpad( arg, ceil32(arg.size) )

      size + value
    end


    def encode_bytes( arg, length=nil )
      raise EncodingError, "Expecting string: #{arg}" unless arg.is_a?(String)
      arg = arg.b

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

def rpad( bin, l=32, symbol=BYTE_ZERO )    ## note: same as builtin String#ljust !!!
  return bin  if bin.size >= l
  bin + symbol * (l - bin.size)
end

def lpad( bin, l=32, symbol=BYTE_ZERO )    ## note: same as builtin String#rjust !!!
  return bin  if bin.size >= l
  symbol * (l - bin.size) + bin
end

def lpad_int( n, l=32, symbol=BYTE_ZERO )
  raise ArgumentError, "Integer invalid or out of range: #{n}" unless n.is_a?(Integer) && n >= 0 && n <= UINT_MAX
  hex = n.to_s(16)
  hex = "0#{hex}"   if hex.size.odd?
  bin = [hex].pack("H*")

  lpad( bin, l, symbol )
end

def lpad_hex( hex, l=32, symbol=BYTE_ZERO )
  raise TypeError, "Value must be a string"  unless hex.is_a?( String )
  raise TypeError, 'Non-hexadecimal digit found' unless hex =~ /\A[0-9a-fA-F]*\z/
  bin = [hex].pack("H*")

  lpad( bin, l, symbol )
end



def ceil32(x)
  x % 32 == 0 ? x : (x + 32 - x%32)
end

end # class Encoder
end  # module ABI

