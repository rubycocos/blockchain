module Ethlite


module Helpers
    def keccak256( bin )
      # Digest::SHA3.new(256).digest(x)
      ## Digest::Keccak.digest(x, 256)
      Digest::KeccakLite.new(256).digest( bin )
    end

    def encode_hex( bin )   ## bin_to_hex
      raise TypeError, "Value must be a string" unless bin.is_a?( String )
      ## note: always return a hex string with default encoding e.g. utf-8 - why? why not?
      bin.unpack("H*").first.force_encoding( Encoding::UTF_8 )
    end
    alias_method :bin_to_hex, :encode_hex

    def decode_hex( hex )   ## hex_to_bin
      raise TypeError, "Value must be a string" unless hex.is_a?( String )
      raise TypeError, 'Non-hexadecimal char found' unless hex.empty? || hex =~ /\A(0x)?[0-9a-fA-F]{2,}\z/

      ## allow optional starting 0x - why? why not?
      hex = hex[2..-1]   if hex[0,2] == '0x'

      [hex].pack("H*")
    end
    alias_method :hex_to_bin, :decode_hex
end  # module Helpers



module Utils
   extend Helpers
end

end  # module Ethlite

