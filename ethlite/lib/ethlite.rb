require 'cocos'

require 'uri'
require 'net/http'
require 'net/https'
require 'json'


require 'openssl'
require 'digest'

## 3rd party gems
require 'rlp-lite'
require 'digest-lite'


require_relative 'jsonrpc/jsonrpc'


## our own code
require_relative 'ethlite/version'    # note: let version always go first

require_relative 'ethlite/constant'
require_relative 'ethlite/utils'


require_relative 'ethlite/abi/type'
require_relative 'ethlite/abi/codec'


require_relative 'ethlite/contract'




module Ethlite
class Configuration
  def rpc()       @rpc || JsonRpc.new( ENV['INFURA_URI'] ); end
  def rpc=(value)
    @rpc =   if value.is_a?( String )
                 JsonRpc.new( value )   ## auto-wrap in (built-in/simple) jsonrpc client/serverproxy
             else
                value
             end
  end
end # class Configuration


## lets you use
##   Ethlite.configure do |config|
##      config.rpc = Ethlite::Rpc.new( ENV['INFURA_URI'] )
##   end
def self.configure() yield( config ); end
def self.config()    @config ||= Configuration.new;  end
end  # module Ethlite




## add convenience alternate spelling
EthLite      = Ethlite


puts Ethlite.banner    # say hello

