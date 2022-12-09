

  module Rlp
    module Sedes

      # A serializable, big-endian, unsigned integer type.
      class BigEndianInt

        # Create a serializable, big-endian, unsigned integer.
        #
        # @param size [Integer] the size of the big endian.
        def initialize(size = nil)
          @size = size
        end

        # Serialize a big-endian integer.
        #
        # @param obj [Integer] the integer to be serialized.
        # @return [String] a serialized big-endian integer.
        # @raise [SerializationError] if provided object is not an integer.
        # @raise [SerializationError] if provided integer is negative.
        # @raise [SerializationError] if provided integer is too big for @size.
        def serialize(obj)
          raise SerializationError, "Can only serialize integers" unless obj.is_a?(Integer)
          raise SerializationError, "Cannot serialize negative integers" if obj < 0
          raise SerializationError, "Integer too large (does not fit in #{@size} bytes)" if @size && obj >= 256 ** @size
          s = obj == 0 ? BYTE_EMPTY : _int_to_big_endian( obj )
          @size ? "#{BYTE_ZERO * [0, @size - s.size].max}#{s}" : s
        end

        # Deserializes an unsigned integer.
        #
        # @param serial [String] the serialized integer.
        # @return [Integer] a number.
        # @raise [DeserializationError] if provided serial is of wrong size.
        # @raise [DeserializationError] if provided serial is not of minimal length.
        def deserialize(serial)
          raise DeserializationError, "Invalid serialization (wrong size)" if @size && serial.size != @size
          raise DeserializationError, "Invalid serialization (not minimal length)" if !@size && serial.size > 0 && serial[0] == BYTE_ZERO
          serial = serial || BYTE_ZERO
          _big_endian_to_int( serial )
        end


###
#  private helpers


 # Converts an integer to big endian.
    #
    # @param num [Integer] integer to be converted.
    # @return [String] packed, big-endian integer string.
    def _int_to_big_endian( num )
      hex = num.to_s(16)
      hex = "0#{hex}"   if hex.size.odd?

      [hex].pack("H*")    ## note Util.hex_to_bin() "inline" shortcut
    end

   # Converts a big endian to an interger.
    #
    # @param str [String] big endian to be converted.
    # @return [Integer] an unpacked integer number.
    def _big_endian_to_int(str)
      str.unpack("H*").first.to_i(16)
    end



end  # class BigEndianInt

end  # module Sedes
end  # module Rlp
