module Ethlite


module UtilHelper
    ##
    # Not the keccak in sha3, although it's underlying lib named SHA3
    #
    def keccak256(x)
      # Digest::SHA3.new(256).digest(x)
      ## Digest::Keccak.digest(x, 256)
      Digest::KeccakLite.new(256).digest( x )
    end

    ## todo/check where required / in use - what for?
    def keccak512(x)
      # Digest::SHA3.new(512).digest(x)
      # Digest::Keccak.digest(x, 512)
      Digest::KeccakLite.new(512).digest( x )
    end


    def keccak256_rlp(x)
      keccak256 RLP.encode(x)
    end

    def sha256(x)
      Digest::SHA256.digest x
    end

    def double_sha256(x)
      sha256 sha256(x)
    end

    def ripemd160(x)
      Digest::RMD160.digest x
    end

    def hash160(x)
      ripemd160 sha256(x)
    end

    def hash160_hex(x)
      encode_hex hash160(x)
    end

    def mod_exp(x, y, n)
      x.to_bn.mod_exp(y, n).to_i
    end

    def mod_mul(x, y, n)
      x.to_bn.mod_mul(y, n).to_i
    end

    def to_signed(i)
      i > INT_MAX ? (i-TT256) : i
    end


    def ceil32(x)
      x % 32 == 0 ? x : (x + 32 - x%32)
    end

    def encode_hex(b)
      raise TypeError, "Value must be an instance of String" unless b.instance_of?(String)
      b.unpack("H*").first
    end

    def decode_hex(str)
      raise TypeError, "Value must be an instance of string" unless str.instance_of?(String)
      raise TypeError, 'Non-hexadecimal digit found' unless str =~ /\A[0-9a-fA-F]*\z/
      [str].pack("H*")
    end




    def int_to_big_endian(n)
      RLP::Sedes.big_endian_int.serialize n
    end

    def big_endian_to_int(s)
      RLP::Sedes.big_endian_int.deserialize s.sub(/\A(\x00)+/, '')
    end


    def encode_int(n)
      raise ArgumentError, "Integer invalid or out of range: #{n}" unless n.is_a?(Integer) && n >= 0 && n <= UINT_MAX
      int_to_big_endian n
    end

    def decode_int(v)
      raise ArgumentError, "No leading zero bytes allowed for integers" if v.size > 0 && (v[0] == BYTE_ZERO || v[0] == 0)
      big_endian_to_int v
    end




    def lpad(x, symbol, l)
      return x if x.size >= l
      symbol * (l - x.size) + x
    end

    def rpad(x, symbol, l)
      return x if x.size >= l
      x + symbol * (l - x.size)
    end

    def zpad(x, l)
      lpad x, BYTE_ZERO, l
    end

    def zunpad(x)
      x.sub /\A\x00+/, ''
    end

    def zpad_int(n, l=32)
      zpad encode_int(n), l
    end

    def zpad_hex(s, l=32)
      zpad decode_hex(s), l
    end

    def int_to_addr(x)
      zpad_int x, 20
    end


    def bytearray_to_int(arr)
      o = 0
      arr.each {|x| o = (o << 8) + x }
      o
    end

    def int_array_to_bytes(arr)
      arr.pack('C*')
    end

    def bytes_to_int_array(bytes)
      bytes.unpack('C*')
    end


    def coerce_to_int(x)
      if x.is_a?(Numeric)
        x
      elsif x.size == 40
        big_endian_to_int decode_hex(x)
      else
        big_endian_to_int x
      end
    end

    def coerce_to_bytes(x)
      if x.is_a?(Numeric)
        int_to_big_endian x
      elsif x.size == 40
        decode_hex(x)
      else
        x
      end
    end

    def coerce_addr_to_hex(x)
      if x.is_a?(Numeric)
        encode_hex zpad(int_to_big_endian(x), 20)
      elsif x.size == 40 || x.size == 0
        x
      else
        encode_hex zpad(x, 20)[-20..-1]
      end
    end



    def parse_int_or_hex(s)
      if s.is_a?(Numeric)
        s
      elsif s[0,2] == '0x'
        big_endian_to_int decode_hex(normalize_hex_without_prefix(s))
      else
        s.to_i
      end
    end


=begin
  ## add? moved over from the old module Utility
     def hex( num )
        '0x' + num.to_s(16)
      end

      def from_hex( h )
        h.nil? ? 0 : (h.kind_of?(String) ? h.to_i(16) : h)
      end
=end


    def remove_0x_head( s )
      return s if !s || s.length<2
      s[0,2] == '0x' ? s[2..-1] : s
    end

    def normalize_hex_without_prefix(s)
      if s[0,2] == '0x'
        (s.size % 2 == 1 ? '0' : '') + s[2..-1]
      else
        s
      end
    end

    def signature_hash( signature, length=8 )
      encode_hex( keccak256(signature) )[0...length]
    end

end  # module UtilHelper



module Utils
   extend UtilHelper
end

end  # module Ethlite

