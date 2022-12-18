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



##  our own code
require_relative 'etherscan-lite/version'

### add (shared) "global" config
module Etherscan
  class Configuration

    #######################
    ## accessors
    ##  todo/check - change to apikey or api_key or such - why? why not?
    def key()       @key ||= ENV['ETHERSCAN_KEY']; end
    def key=(value) @key = value; end
  end # class Configuration


  ## lets you use
  ##   Ethersan.configure do |config|
  ##      config.key = 'xxxx'
  ##   end
  def self.configure() yield( config ); end
  def self.config()    @config ||= Configuration.new;  end
  end  # module Etherscan


require_relative 'etherscan-lite/base'
require_relative 'etherscan-lite/account'
require_relative 'etherscan-lite/contract'
require_relative 'etherscan-lite/proxy'
require_relative 'etherscan-lite/misc'



puts EtherscanLite.banner    # say hello

