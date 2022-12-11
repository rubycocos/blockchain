module CryptoHelper


###
#  todo:  change ''.b to BYTE_ZERO constant or such - why? why not?


  ######
  #  add convenience helpers
  def base58( bin=''.b, hex: nil )
    bin = hex.hex_to_bin  if hex      # uses Bytes.hex_to_bin
    Crypto::Metal.base58( bin )
  end

  def base58check( bin=''.b, hex: nil )
    bin = hex.hex_to_bin  if hex      # uses Bytes.hex_to_bin
    Crypto::Metal.base58check( bin )
  end

  def keccak256( bin=''.b, hex: nil )
     bin = hex.hex_to_bin  if hex      # uses Bytes.hex_to_bin
     Crypto::Metal.keccak256( bin )
  end

  def rmd160( bin=''.b, hex: nil )
    bin = hex.hex_to_bin  if hex      # uses Bytes.hex_to_bin
    Crypto::Metal.rmd160( bin )
  end
  ## add alias RIPEMD160 - why? why not?
  alias_method :ripemd160, :rmd160

  def sha256( bin=''.b, hex: nil,
                   engine: nil )
    bin = hex.hex_to_bin  if hex      # uses Bytes.hex_to_bin
    Crypto::Metal.sha256( bin, engine )
  end

  def sha3_256( bin=''.b, hex: nil,
                     engine: nil )
    bin = hex.hex_to_bin  if hex      # uses Bytes.hex_to_bin
    Crypto::Metal.sha3_256( bin, engine )
  end

  def hash160( bin=''.b, hex: nil )
    bin = hex.hex_to_bin  if hex      # uses Bytes.hex_to_bin
    Crypto::Metal.hash160( bin )
  end

  def hash256( bin=''.b, hex: nil )
    bin = hex.hex_to_bin  if hex      # uses Bytes.hex_to_bin
    Crypto::Metal.hash256( bin )
  end
end # module CryptoHelper



module Crypto
  extend CryptoHelper
     ##
     ##  lets you use
     ##    Crypto.sha256( bin, hex: ) -> bin
     ##    Crytpo.base58( bin, hex: ) -> bin
     ##    etc.
end  # module Crypto
