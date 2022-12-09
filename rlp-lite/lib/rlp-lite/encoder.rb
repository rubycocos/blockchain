
  module Rlp


    # Provides an RLP-encoder.
    class Encoder


      # Encodes a Ruby object in RLP format.
      #
      # @param obj [Object] a Ruby object.
      # @return [String] the RLP encoded item.
      # @raise [Rlp::EncodingError] in the rather unlikely case that the item
      #     is too big to encode (will not happen).
      # @raise [Rlp::SerializationError] if the serialization fails.
      def perform( obj )
        item = Sedes.infer(obj).serialize(obj)
        result = encode_raw( item )
      end


    private

      # Encodes the raw item.
      def encode_raw( item )
        if item.instance_of?( Rlp::Data )
          item
        elsif Util.is_primitive?( item )
          encode_primitive item
        elsif Util.is_list?( item )
          encode_list item
        else
          raise EncodingError "Cannot encode object of type #{item.class.name}"
        end
      end


      # Encodes a single primitive.
      def encode_primitive(item)
        return Util.str_to_bytes item if item.size == 1 && item.ord < PRIMITIVE_PREFIX_OFFSET
        payload = Util.str_to_bytes item
        prefix = length_prefix payload.size, PRIMITIVE_PREFIX_OFFSET
        "#{prefix}#{payload}"
      end

      # Encodes a single list.
      def encode_list(list)
        payload = list.map { |item| encode_raw item }.join
        prefix = length_prefix payload.size, LIST_PREFIX_OFFSET
        "#{prefix}#{payload}"
      end

      # Determines a length prefix.
      def length_prefix(length, offset)
        if length < SHORT_LENGTH_LIMIT
          (offset + length).chr
        elsif length < LONG_LENGTH_LIMIT
          length_string = Util.int_to_big_endian( length )
          length_len = (offset + SHORT_LENGTH_LIMIT - 1 + length_string.size).chr
          "#{length_len}#{length_string}"
        else
          raise EncodingError, "Length greater than 256**8: #{length}"
        end
      end
    end
end   # module Rlp
