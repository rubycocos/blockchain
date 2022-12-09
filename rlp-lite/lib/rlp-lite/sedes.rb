

  module Rlp
    module Sedes

      # Provides a {Rlp::Sedes} module to infer objects and types.

        # Tries to find a sedes objects suitable for a given Ruby object.
        #
        # The sedes objects considered are `obj`'s class, {big_endian_int} and
        # {binary}. If `obj` is a list, an {Rlp::Sedes::List} will be
        # constructed recursively.
        #
        # @param obj [Object] the Ruby object for which to find a sedes object.
        # @raise [TypeError] if no appropriate sedes could be found.
        def self.infer( obj )
          if is_sedes?( obj.class )
            obj.class
          elsif obj.is_a?(Integer) && obj >= 0
            big_endian_int
          elsif Binary.valid_type?( obj )    ## note: same as obj.is_a?( String )
            binary
          elsif Util.is_list?( obj )
            List.new( elements: obj.map { |item| infer( item ) } )
          else
            raise TypeError, "Did not find sedes handling type #{obj.class.name}"
          end
        end


        # Determines if an object is a sedes object.
        #
        # @param obj [Object] the object to check.
        # @return [Boolean] true if it's serializable and deserializable.
        def self.is_sedes?(obj)
          obj.respond_to?(:serialize) && obj.respond_to?(:deserialize)
        end

        # A utility to use a big-endian, unsigned integer sedes type with
        # unspecified length.
        #
        # @return [Rlp::Sedes::BigEndianInt] a big-endian, unsigned integer sedes.
        def self.big_endian_int
          @big_endian_int ||= BigEndianInt.new
        end

        # A utility to use a binary sedes type.
        #
        # @return [Rlp::Sedes::Binary] a binary sedes.
        def self.binary
          @binary ||= Binary.new
        end




end   # module Sedes
end  #  module Rlp
