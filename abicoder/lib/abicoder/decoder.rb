module ABI


class Decoder

    ##
    # Decodes multiple arguments using the head/tail mechanism.
    #
    def decode( types, data, raise_errors = false )
      ## for convenience check if types is a String
      ##   otherwise assume ABI::Type already
      types = types.map { |type| type.is_a?( Type ) ? type : Type.parse( type ) }

      outputs = [nil] * types.size
      start_positions = [nil] * types.size + [data.size]

      # TODO: refactor, a reverse iteration will be better
      pos = 0
      types.each_with_index do |t, i|
        # If a type is static, grab the data directly, otherwise record its
        # start position
        if t.dynamic?

          if raise_errors && pos>data.size-1
            raise DecodingError, "Position out of bounds #{pos}>#{data.size-1}"
          end

          start_positions[i] = Utils.big_endian_to_int(data[pos, 32])

          if raise_errors && start_positions[i]>data.size-1
            raise DecodingError, "Start position out of bounds #{start_positions[i]}>#{data.size-1}"
          end

          j = i - 1
          while j >= 0 && start_positions[j].nil?
            start_positions[j] = start_positions[i]
            j -= 1
          end

          pos += 32
        else
          outputs[i] = zero_padding( data, pos, t.size, start_positions )
          pos += t.size
        end
      end

      # We add a start position equal to the length of the entire data for
      # convenience.
      j = types.size - 1
      while j >= 0 && start_positions[j].nil?
        start_positions[j] = start_positions[types.size]
        j -= 1
      end

      if raise_errors && pos > data.size
        raise DecodingError, "Not enough data for head"
      end


      types.each_with_index do |t, i|
        if t.dynamic?
          offset, next_offset = start_positions[i, 2]
          if offset<=data.size && next_offset<=data.size
            outputs[i] = data[offset...next_offset]
          end
        end
      end

      if raise_errors && outputs.include?(nil)
        raise DecodingError, "Not all data can be parsed"
      end

      types.zip(outputs).map {|(type, out)| decode_type(type, out) }
    end



    def decode_type(type, arg)
      return nil if arg.nil? || arg.empty?

      if type.kind_of?( Tuple ) && type.dims.empty?
        arg ? decode(type.types, arg) : []
      elsif ['string', 'bytes'].include?(type.base) && type.sub.empty?
        l = Utils.big_endian_to_int arg[0,32]
        data = arg[32..-1]
        data[0, l]
      elsif !type.dims.empty? && (l = type.dims.last) > 0   # static-sized arrays
        subtype = type.subtype
        if subtype.dynamic?
          start_positions = (0...l).map {|i| Utils.big_endian_to_int(arg[32*i, 32]) }
          start_positions.push arg.size

          outputs = (0...l).map {|i| arg[start_positions[i]...start_positions[i+1]] }

          outputs.map {|out| decode_type(subtype, out) }
        else
          (0...l).map {|i| decode_type(subtype, arg[subtype.size*i, subtype.size]) }
        end

      elsif type.dynamic?
        l = Utils.big_endian_to_int arg[0,32]
        raise DecodingError, "Too long length: #{l}" if l>100000
        subtype = type.subtype

        if subtype.dynamic?
          raise DecodingError, "Not enough data for head" unless arg.size >= 32 + 32*l

          start_positions = (1..l).map {|i| 32+Utils.big_endian_to_int(arg[32*i, 32]) }
          start_positions.push arg.size

          outputs = (0...l).map {|i| arg[start_positions[i]...start_positions[i+1]] }

          outputs.map {|out| decode_type(subtype, out) }
        else
          (0...l).map {|i| decode_type(subtype, arg[32 + subtype.size*i, subtype.size]) }
        end

      else
        decode_primitive_type type, arg
      end
    end


    def decode_primitive_type(type, data)
      case type.base
      when 'address'
        Utils.encode_hex data[12..-1]
      when 'string', 'bytes'
        if type.sub.empty? # dynamic
          if data.length==32
            data[0..32]
          else
            size = Utils.big_endian_to_int data[0,32]
            data[32..-1][0,size]
          end
        else # fixed
          data[0, type.sub.to_i]
        end
      when 'uint'
        Utils.big_endian_to_int data
      when 'int'
        u = Utils.big_endian_to_int data
        u >= 2**(type.sub.to_i-1) ? (u - 2**type.sub.to_i) : u
      when 'bool'
        data[-1] == BYTE_ONE
      else
        raise DecodingError, "Unknown primitive type: #{type.base}"
      end
    end


    def zero_padding( data, pos, count, start_positions )
      if pos >= data.size
        start_positions[start_positions.size-1] += count
        "\x00"*count
      elsif pos + count > data.size
        start_positions[start_positions.size-1] += ( count - (data.size-pos))
        data[pos,data.size-pos] + "\x00"*( count - (data.size-pos))
      else
        data[pos, count]
      end
    end


end  # class Decoder

end   ## module ABI