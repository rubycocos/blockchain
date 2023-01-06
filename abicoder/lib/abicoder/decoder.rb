module ABI


class Decoder

    ##
    # Decodes multiple arguments using the head/tail mechanism.
    #
    def decode( types, data, raise_errors = false )
       ##
       ##  todo/check:  always change data (string) to binary encoding (e.g. data = data.b )
       ##                    or such - why? why not?

      ## for convenience check if types is a String
      ##   otherwise assume ABI::Type already
      types = types.map { |type| type.is_a?( Type ) ? type : Type.parse( type ) }

      outputs = [nil] * types.size
      start_positions = [nil] * types.size + [data.size]

      # TODO: refactor, a reverse iteration will be better - why? why not?
      #   try to simplify / clean-up code - possible? why? why not?

      pos = 0
      types.each_with_index do |t, i|
        # If a type is static, grab the data directly, otherwise record its
        # start position
        if t.dynamic?

          if pos>data.size-1
            if raise_errors
              raise DecodingError, "Position out of bounds #{pos}>#{data.size-1}"
            else
              puts "!! WARN - DecodingError: Position out of bounds #{pos}>#{data.size-1}"
            end
          end

          start_positions[i] = decode_uint256(data[pos, 32])

          if start_positions[i]>data.size-1
            if raise_errors
              raise DecodingError, "Start position out of bounds #{start_positions[i]}>#{data.size-1}"
            else
              puts "!! WARN - DecodingError: Start position out of bounds #{start_positions[i]}>#{data.size-1}"
            end
          end


          j = i - 1
          while j >= 0 && start_positions[j].nil?
            start_positions[j] = start_positions[i]
            j -= 1
          end

          pos += 32
        else
          ## puts "step 1 - decode item [#{i}] - #{t.format}  size: #{t.size} dynamic? #{t.dynamic?}"

          count = t.size
          ## was zero_padding( data, pos, t.size, start_positions )
          ##   inline for now and clean-up later - why? why not?
          outputs[i] = if pos >= data.size
                          start_positions[start_positions.size-1] += count
                          BYTE_ZERO*count
                        elsif pos + count > data.size
                          start_positions[start_positions.size-1] += ( count - (data.size-pos))
                          data[pos,data.size-pos] + BYTE_ZERO*( count - (data.size-pos))
                        else
                          data[pos, count]
                        end

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

      if pos > data.size
        if raise_errors
          raise DecodingError, "Not enough data for head"
        else
          puts "!! WARN - DecodingError: Not enough data for head"
        end
      end


      types.each_with_index do |t, i|
        if t.dynamic?
          offset, next_offset = start_positions[i, 2]
          if offset<=data.size && next_offset<=data.size
            outputs[i] = data[offset...next_offset]
          end
        end
      end

      if outputs.include?( nil )
        if raise_errors
          raise DecodingError, "Not all data can be parsed"
        else
          puts "!! WARN: DecodingError - Not all data can be parsed"
        end
      end


      types.zip(outputs).map do |(t, out)|
         ## puts "step 2 - decode item - #{t.format} got: #{out.size} byte(s) -  size: #{t.size} dynamic? #{t.dynamic?}"

         decode_type(t, out)
      end
    end




    def decode_type( type, data )
      return nil    if data.nil? || data.empty?

      if type.is_a?( Tuple )   ## todo: support empty (unit) tuple - why? why not?
          decode( type.types, data )
      elsif type.is_a?( FixedArray )   # static-sized arrays
        l       = type.dim
        subtype = type.subtype
        if subtype.dynamic?
          start_positions = (0...l).map {|i| decode_uint256(data[32*i, 32]) }
          start_positions.push( data.size )

          outputs = (0...l).map {|i| data[start_positions[i]...start_positions[i+1]] }

          outputs.map {|out| decode_type(subtype, out) }
        else
          (0...l).map {|i| decode_type(subtype, data[subtype.size*i, subtype.size]) }
        end
      elsif type.is_a?( Array )
        l = decode_uint256( data[0,32] )
        raise DecodingError, "Too long length: #{l}"  if l > 100000
        subtype = type.subtype

        if subtype.dynamic?
          raise DecodingError, "Not enough data for head" unless data.size >= 32 + 32*l

          start_positions = (1..l).map {|i| 32+decode_uint256(data[32*i, 32]) }
          start_positions.push( data.size )

          outputs = (0...l).map {|i| data[start_positions[i]...start_positions[i+1]] }

          outputs.map {|out| decode_type(subtype, out) }
        else
          (0...l).map {|i| decode_type(subtype, data[32 + subtype.size*i, subtype.size]) }
        end
      else
        decode_primitive_type( type, data )
      end
    end


    def decode_primitive_type(type, data)
      case type
      when Uint
        decode_uint256( data )
      when Int
        u = decode_uint256( data )
        u >= 2**(type.bits-1) ? (u - 2**type.bits) : u
      when Bool
        data[-1] == BYTE_ONE
      when String
        ## note: convert to a string (with UTF_8 encoding NOT BINARY!!!)
        size = decode_uint256( data[0,32] )
        data[32..-1][0,size].force_encoding( Encoding::UTF_8 )
      when Bytes
        size = decode_uint256( data[0,32] )
        data[32..-1][0,size]
      when FixedBytes
        data[0, type.length]
      when Address
        ## note: convert to a hex string (with UTF_8 encoding NOT BINARY!!!)
        data[12..-1].unpack("H*").first.force_encoding( Encoding::UTF_8 )
      else
        raise DecodingError, "Unknown primitive type: #{type.class.name} #{type.format}"
      end
    end



###########
#  decoding helpers / utils

def decode_uint256( bin )
  # bin = bin.sub( /\A(\x00)+/, '' )   ## keep "performance" shortcut - why? why not?
  ### todo/check - allow nil - why? why not?
  ##  raise DeserializationError, "Invalid serialization (not minimal length)" if !@size && serial.size > 0 && serial[0] == BYTE_ZERO
  # bin = bin || BYTE_ZERO
  bin.unpack("H*").first.to_i(16)
end



end  # class Decoder

end   ## module ABI