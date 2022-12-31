
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

      head_size = (0...args.size)
        .map {|i| types[i].size || 32 }
        .sum    ## was: reduce(0, &:+) -  to add up array use sum - why? why not?


      head, tail = '', ''
      args.each_with_index do |arg, i|
        if types[i].dynamic?
          head += encode_uint256( head_size + tail.size )
          tail += encode_type(types[i], arg)
        else
          head += encode_type(types[i], arg)
        end
      end

      "#{head}#{tail}"
    end

    ##
    # Encodes a single value (static or dynamic).
    #
    # @param type [ABI::Type] value type
    # @param arg [Object] value
    #
    # @return [String] encoded bytes
    #
    def encode_type(type, arg)
      if ['string', 'bytes'].include?(type.base) && type.sub.empty?
        encode_primitive_type type, arg
      elsif type.dynamic?
        raise ArgumentError, "arg must be an array" unless arg.instance_of?(Array)

        head, tail = '', ''
        if type.dims.last == 0
          head += encode_uint256( arg.size )
        else
          raise ArgumentError, "Wrong array size: found #{arg.size}, expecting #{type.dims.last}" unless arg.size == type.dims.last
        end

        sub_type = type.subtype
        sub_size = type.subtype.size
        arg.size.times do |i|
          if sub_size.nil?
            head += encode_uint256( 32*arg.size + tail.size )
            tail += encode_type(sub_type, arg[i])
          else
            head += encode_type(sub_type, arg[i])
          end
        end

        "#{head}#{tail}"
      else # static type
        if type.dims.empty?
          encode_primitive_type type, arg
        else
          arg.map {|x| encode_type(type.subtype, x) }.join
        end
      end
    end



    def encode_primitive_type( type, arg )
      case type.base
      when 'uint'
        ## note: for now size in  bits always required
        encode_uint( arg, type.sub.to_i )
      when 'int'
        ## note: for now size in  bits always required
        encode_int( arg, type.sub.to_i )
      when 'bool'
        encode_bool( arg )
      when 'string'
        encode_string( arg )
      when 'bytes'
        ## note: if no length/size in bytes than
        #          bytes  is dynamic otherweise
        #          bytes1, bytes2, .. bytes32 is fixed
        encode_bytes( arg, type.sub.empty? ? nil : type.sub.to_i )
      when 'address'
        encode_address( arg )
      else
        raise EncodingError, "Unhandled type: #{type.base} #{type.sub}"
      end
    end



    def encode_bool( arg )
      raise ArgumentError, "arg is not bool: #{arg}" unless arg.instance_of?(TrueClass) || arg.instance_of?(FalseClass)
      Utils.zpad_int( arg ? 1 : 0 )
    end


    def encode_uint256( arg ) encode_uint( arg, 256 ); end
    def encode_uint( arg, bits )
      begin
        i = get_uint( arg )

        raise ValueOutOfBounds, arg   unless i >= 0 && i < 2**bits
        Utils.zpad_int i
      rescue EncodingError
        raise ValueOutOfBounds, arg
      end
    end

    def encode_int( arg, bits )
      begin
        i = get_int( arg )

        raise ValueOutOfBounds, arg   unless i >= -2**(bits-1) && i < 2**(bits-1)
        Utils.zpad_int(i % 2**bits)
      rescue EncodingError
        raise ValueOutOfBounds, arg
      end
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

      raise ValueOutOfBounds, "Integer invalid or out of range: #{arg.size}" if arg.size >= TT256
      size = Utils.zpad_int arg.size
      value = Utils.rpad arg, BYTE_ZERO, Utils.ceil32(arg.size)
      "#{size}#{value}"
    end


    def encode_bytes( arg, length=nil )
      raise EncodingError, "Expecting string: #{arg}" unless arg.instance_of?(String)
      arg = arg.b

      if length # fixed length type
        raise ValueOutOfBounds, "invalid bytes length #{length}" if arg.size > length
        raise ValueOutOfBounds, "invalid bytes length #{length}" if length < 0 || length > 32
        Utils.rpad( arg, BYTE_ZERO, 32 )
      else  # variable length type  (if length is nil)
        raise ValueOutOfBounds, "Integer invalid or out of range: #{arg.size}" if arg.size >= TT256
        size = Utils.zpad_int arg.size
        value = Utils.rpad arg, BYTE_ZERO, Utils.ceil32(arg.size)
        "#{size}#{value}"
      end
    end


    def encode_address( arg )
      if arg.is_a?(Integer)
        Utils.zpad_int arg
      elsif arg.size == 20
        Utils.zpad arg, 32
      elsif arg.size == 40
        Utils.zpad_hex arg
      elsif arg.size == 42 && arg[0,2] == '0x'
        Utils.zpad_hex arg[2..-1]
      else
        raise EncodingError, "Could not parse address: #{arg}"
      end
    end

=begin
    def min_data_size( types )
       types.size*32
    end
=end


private

    def get_uint(n)
      case n
      when Integer
        raise EncodingError, "Number out of range: #{n}" if n > UINT_MAX || n < UINT_MIN
        n
      when String
        i = if n.size == 40
              Utils.decode_hex(n)
            elsif n.size <= 32
              n
            else
              raise EncodingError, "String too long: #{n}"
            end
        i = Utils.big_endian_to_int i

        raise EncodingError, "Number out of range: #{i}" if i > UINT_MAX || i < UINT_MIN
        i
      when true
        1
      when false, nil
        0
      else
        raise EncodingError, "Cannot decode uint: #{n}"
      end
    end

    def get_int(n)
      case n
      when Integer
        raise EncodingError, "Number out of range: #{n}" if n > INT_MAX || n < INT_MIN
        n
      when String
        i = if n.size == 40
              Utils.decode_hex(n)
            elsif n.size <= 32
              n
            else
              raise EncodingError, "String too long: #{n}"
            end
        i = Utils.big_endian_to_int i

        i = i > INT_MAX ? (i-TT256) : i
        raise EncodingError, "Number out of range: #{i}" if i > INT_MAX || i < INT_MIN
        i
      when true
        1
      when false, nil
        0
      else
        raise EncodingError, "Cannot decode int: #{n}"
      end
    end
end # class Encoder



end  # module ABI

