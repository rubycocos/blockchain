
module CryptoHelper
  ### note: use include CryptoHelper
  ##          to get "top-level" / global helpers

  ## add convenience "top-level" helpers
  def sha256( *args, **kwargs )    Crypto.sha256( *args, **kwargs ); end
  def sha3_256( *args, **kwargs )    Crypto.sha3_256( *args, **kwargs ); end

  def keccak256( *args, **kwargs )    Crypto.keccak256( *args, **kwargs ); end

  def rmd160( *args, **kwargs )    Crypto.rmd160( *args, **kwargs ); end
  ## def ripemd160( input ) Crypto.rmd160( input ); end
  alias_method :ripemd160, :rmd160

  def hash160( *args, **kwargs )    Crypto.hash160( *args, **kwargs ); end

  def hash256( *args, **kwargs )    Crypto.hash256( *args, **kwargs ); end


  def base58( *args, **kwargs )      Crypto.base58( *args, **kwargs ); end
  def base58check( *args, **kwargs ) Crypto.base58check( *args, **kwargs ); end
end


