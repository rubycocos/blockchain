module Crypto


  module RSA
    def self.generate_keys  ## todo/check: add a generate alias - why? why not?
      key_pair = OpenSSL::PKey::RSA.new( 2048 )
      private_key = key_pair.export
      public_key  = key_pair.public_key.export

      [private_key, public_key]
    end


    def self.sign( plaintext, private_key )
      private_key = OpenSSL::PKey::RSA.new( private_key ) ## note: convert/wrap into to obj from exported text format
      Base64.encode64( private_key.private_encrypt( plaintext ))
    end

    def self.decrypt( ciphertext, public_key )
      public_key = OpenSSL::PKey::RSA.new( public_key )  ## note: convert/wrap into to obj from exported text format
      public_key.public_decrypt( Base64.decode64( ciphertext ))
    end


    def self.valid_signature?( plaintext, ciphertext, public_key )
      plaintext == decrypt( ciphertext, public_key )
    end
  end # module RSA
end   # module Crypto
