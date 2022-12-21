require 'bytes'
require 'ethlite'


## extend String
class String
  alias_method :hexdigest, :bin_to_hex   ## note: bin_to_hex added via Bytes!!!
end  # class String


def keccak256( bin )
  Ethlite::Utils.keccak256( bin )
end

def sig( bin )
  keccak256( bin )[0,4]
end



## our own code
require_relative 'abidoc/param'
require_relative 'abidoc/constructor'
require_relative 'abidoc/function'

require_relative 'abidoc/abi'

