
  module Rlp
    module Sedes

      # A sedes type for lists of fixed length.
      class List < Array

        # Create a serializable list of fixed size.
        #
        # @param elements [Array] an array indicating the structure of the list.
        # @param strict [Boolean] an option to enforce the given structure.
        def initialize( elements: [], strict: true )
          super()

          @strict = strict
          elements.each do |e|
            if Sedes.is_sedes?(e)
              push e
            elsif Util.is_list?(e)
              push List.new(elements: e)
            else
              raise TypeError, "Instances of List must only contain sedes objects or nested sequences thereof."
            end
          end
        end

        # Serialize an array.
        #
        # @param obj [Array] the array to be serialized.
        # @return [Array] a serialized list.
        # @raise [SerializationError] if provided array is not a sequence.
        # @raise [SerializationError] if provided array is of wrong length.
        def serialize( obj )
          raise SerializationError, "Can only serialize sequences" unless Util.is_list?(obj)
          raise SerializationError, "List has wrong length" if (@strict && self.size != obj.size) || self.size < obj.size
          result = []
          obj.zip(self).each_with_index do |(element, sedes), i|
            result.push sedes.serialize(element)
          end
          result
        end

        # Deserializes a list.
        #
        # @param serial [Array] the serialized list.
        # @return [Array] a deserialized list.
        # @raise [DeserializationError] if provided serial is not a sequence.
        # @raise [DeserializationError] if provided serial is of wrong length.
        def deserialize(serial)
          raise DeserializationError, "Can only deserialize sequences" unless Util.is_list?(serial)
          raise DeserializationError, "List has wrong length" if @strict && serial.size != self.size
          result = []
          len = [serial.size, self.size].min
          len.times do |i|
            sedes = self[i]
            element = serial[i]
            result.push sedes.deserialize(element)
          end
          result.freeze
        end



end  #  class List


end   # module Sedes
end   # module Rlp
