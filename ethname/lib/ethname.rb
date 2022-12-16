require 'cocos'



## our own code
require_relative 'ethname/version'
require_relative 'ethname/dictionary'


module Ethname

def self.dict
   @dict ||= Dictionary.read( "#{root}/config/contracts.2017.csv",
                              "#{root}/config/contracts.2021.csv",
                              "#{root}/config/contracts.2022.csv",
                            )
end

def self.lookup( q )
  dict.lookup( q )
end
class << self
  alias_method :[], :lookup
end

end  # module Ethname



Ethname.banner   ## say hello