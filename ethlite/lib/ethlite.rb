require 'cocos'


### todo/fix:
##  move .env  loader to
##    cocos - why? why not?
def load_env( path='./.env' )
  if File.exist?( path )
     puts "==> loading .env settings..."
     env = read_yaml( path )
     puts "    applying .env settings... (merging into ENV)"
     pp env
     env.each do |k,v|
         ENV[k] ||= v
     end
  end
end

load_env



require 'openssl'
require 'digest'


## 3rd party gems
require 'digest-lite'
require 'abicoder'


require_relative 'jsonrpc/jsonrpc'


## our own code
require_relative 'ethlite/version'    # note: let version always go first
require_relative 'ethlite/utils'
require_relative 'ethlite/contract'



module Ethlite
class Configuration
  def rpc()       @rpc ||= JsonRpc.new( ENV['INFURA_URI'] ); end
  def rpc=(value)
    @rpc =   if value.is_a?( String )
                 JsonRpc.new( value )   ## auto-wrap in (built-in/simple) jsonrpc client/serverproxy
             else
                value
             end
  end

  ## add "global" debug switch - why? why not?
  def debug?()   (@debug || false) == true; end
  def debug=(value)   @debug = value;  end
end # class Configuration


## lets you use
##   Ethlite.configure do |config|
##      config.rpc = Ethlite::Rpc.new( ENV['INFURA_URI'] )
##   end
def self.configure() yield( config ); end
def self.config()    @config ||= Configuration.new;  end

## add debug convenience config shortcut - forwarding to config.debug? - why? why not?
def self.debug?()  config.debug?;  end
end  # module Ethlite




## add convenience alternate spelling
EthLite      = Ethlite


puts Ethlite.banner    # say hello

