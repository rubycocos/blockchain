
module Crypto
module MetalHelper

  ####
  #  note: all (digest) hash functions
  #          take in a binary string and return a binary string!!!!

  def base58( bin )
    Base58::Bitcoin.encode_bin( bin )
  end

  def base58check( bin )
    hash256 = hash256( bin )
    base58( bin + hash256[0,4] )
  end


  ########################
  # (secure) hash functions

  def keccak256( bin )
    Digest::KeccakLite.digest( bin, 256 )
  end

  def rmd160( bin )
    Digest::RMD160.digest( bin )
  end
  ## add alias RIPEMD160 - why? why not?
  alias_method :ripemd160, :rmd160


  def sha256( bin, engine=nil )   ## todo/check: add alias sha256b or such to - why? why not?
    if engine && ['openssl'].include?( engine.to_s.downcase )
      ## puts "  engine: #{engine}"    if debug?
      digest = OpenSSL::Digest::SHA256.new
      ## or use OpenSSL::Digest.new( 'SHA256' )
      digest.update( bin )
      digest.digest
    else  ## use "built-in" hash function from digest module
      Digest::SHA256.digest( bin )
    end
  end


  def sha3_256( bin, engine=nil )
    if engine && ['openssl'].include?( engine.to_s.downcase )
      ## puts "  engine: #{engine}"    if debug?
      digest = OpenSSL::Digest.new( 'SHA3-256' )
      digest.update( bin )
      digest.digest
    else  ## use "built-in" hash function from digest module
      Digest::SHA3Lite.digest( bin, 256 )
    end
  end


  ####
  ## helper
  # def hash160( pubkey )
  #  binary    = [pubkey].pack( "H*" )       # Convert to binary first before hashing
  #  sha256    = Digest::SHA256.digest( binary )
  #  ripemd160 = Digest::RMD160.digest( sha256 )
  #              ripemd160.unpack( "H*" )[0]    # Convert back to hex
  # end

  def hash160( bin )
    rmd160(sha256( bin ))
  end

  def hash256( bin )
    sha256(sha256( bin ))
  end
end   #  module MetalHelper


module Metal
  extend MetalHelper
     ##  lets you use
     ##    Crypto::Metal.sha256( bin ) -> bin
     ##    Crytpo::Metal.base58( bin ) -> bin
     ##    etc.
end  # module Metal
end   # module Crypto


