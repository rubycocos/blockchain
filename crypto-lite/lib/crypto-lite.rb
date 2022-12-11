require 'pp'
require 'digest'
require 'base64'
require 'openssl'


## our own 3rd party (2nd party?)
require 'bytes'

## extend String
class String
  alias_method :hexdigest, :bin_to_hex   ## note: bin_to_hex added via Bytes!!!
end


require 'digest-lite'  # e.g. keccak (original submission/proposal NOT official sha3)
require 'base32-alphabets'
require 'base58-alphabets'
require 'elliptic'


## our own code
require_relative 'crypto-lite/version'    # note: let version always go first
require_relative 'crypto-lite/config'
require_relative 'crypto-lite/metal'
require_relative 'crypto-lite/helper'


require_relative 'crypto-lite/sign_rsa'
RSA = Crypto::RSA


## auto-add top-level helpers - why? why not?
include CryptoHelper




puts CryptoLite.banner    ## say hello
