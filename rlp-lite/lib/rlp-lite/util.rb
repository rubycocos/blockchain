
module Rlp
module Util
   extend self


    # Checks if a string is hex-adecimal (string).
    #
    # @param str [String] a string to be checked.
    # @return [String] a match if true; `nil` if not.
    def is_hex?( str )
      return false unless str.is_a?( String )
      str = strip_hex_prefix( str )
      str.match /\A[0-9a-fA-F]*\z/
    end

  # Removes the `0x` prefix of a hexa-decimal string.
    #
    # @param hex [String] a prefixed hex-string.
    # @return [String] an unprefixed hex-string.
    def strip_hex_prefix(hex)
      is_prefixed?( hex ) ? hex[2..-1] : hex
    end
    alias_method :remove_hex_prefix, :strip_hex_prefix
    alias_method :strip_0x,          :strip_hex_prefix   ## add more alias - why? why not?

   # Checks if a string is prefixed with `0x`.
    #
    # @param hex [String] a string to be checked.
    # @return [String] a match if true; `nil` if not.
    def is_prefixed?(hex)
      ## was: hex.match /\A0x/
      ##   tood/check:  add support for (upcase) 0X too - why? why not?
      hex.start_with?( '0x' ) ||
      hex.start_with?( '0X' )
    end
    alias_method :is_hex_prefixed?, :is_prefixed?
    alias_method :start_with_0x?,   :is_prefixed?


     # Packs a hexa-decimal string into a binary string. Also works with
    # `0x`-prefixed strings.
    #
    # @param hex [String] a hexa-decimal string to be packed.
    # @return [String] a packed binary string.
    # @raise [TypeError] if value is not a string or string is not hex.
    def hex_to_bin( hex )
      raise TypeError, "Value must be an instance of String" unless hex.instance_of? String
      hex = remove_hex_prefix( hex )
      raise TypeError, "Non-hexadecimal digit found" unless is_hex? hex
      [hex].pack("H*")
    end

   # Unpacks a binary string to a hexa-decimal string.
    #
    # @param bin [String] a binary string to be unpacked.
    # @return [String] a hexa-decimal string.
    # @raise [TypeError] if value is not a string.
    def bin_to_hex(bin)
      raise TypeError, "Value must be an instance of String" unless bin.instance_of? String
      bin.unpack("H*").first
    end


  # Converts a binary string to bytes.
    #
    # @param str [String] binary string to be converted.
    # @return [Object] the string bytes.
    def str_to_bytes(str)
      is_bytes?(str) ? str : str.b
    end
   ## todo/check  - rename to str_to_binary - why? why not?

      # Checks if a string is a byte-string.
    #
    # @param str [String] a string to check.
    # @return [Boolean] true if it's an ASCII-8bit encoded byte-string.
    def is_bytes?(str)
      str && str.instance_of?(String) && str.encoding.name == 'ASCII-8BIT'
    end
    ## todo/check  - rename to is binary? is_binary?



      # Converts an integer to big endian.
    #
    # @param num [Integer] integer to be converted.
    # @return [String] packed, big-endian integer string.
    def int_to_big_endian( num )
      hex = num.to_s(16)
      hex = "0#{hex}" if hex.size.odd?
      hex_to_bin( hex )
    end



   # Converts a big endian to an interger.
    #
    # @param str [String] big endian to be converted.
    # @return [Integer] an unpacked integer number.
    def big_endian_to_int( str )
      str.unpack("H*")[0].to_i(16)
    end



    # Deserializes big endian data string to integer.
    #
    # @param str [String] serialized big endian integer string.
    # @return [Integer] an deserialized unsigned integer.
    def deserialize_big_endian_to_int(str)
      Sedes.big_endian_int.deserialize str.sub( /\A(\x00)+/, '' )
    end


     # Checks if the given item is a string primitive.
    #
    # @param item [Object] the item to check.
    # @return [Boolean] true if it's a string primitive.
    def is_primitive?( item )
      item.instance_of?(String)
    end

    # Checks if the given item is a list.
    #
    # @param item [Object] the item to check.
    # @return [Boolean] true if it's a list.
    def is_list?( item )
      !is_primitive?(item) && item.respond_to?(:each)
    end




end   # module Util
end   # module Rlp
