require 'cocos'
require 'bytes'
require 'digest-lite'


## extend String
class String
  alias_method :hexdigest, :bin_to_hex   ## note: bin_to_hex added via Bytes!!!
end  # class String


def keccak256( bin )
  Digest::KeccakLite.new( 256 ).digest( bin )
end

def sig( bin )
  keccak256( bin )[0,4]
end



## our own code
require_relative 'abiparser/version'    # note: let version always go first
require_relative 'abiparser/param'
require_relative 'abiparser/constructor'
require_relative 'abiparser/function'
require_relative 'abiparser/contract'

require_relative 'abiparser/export/interface.rb'



module ABI
  def self.read( path )  Contract.read( path ); end

  def self.parse( data ) Contract.parse( data ); end
end  # module ABI


## add convenience alternate spellings - why? why not?
Abi = ABI


puts AbiParser.banner

