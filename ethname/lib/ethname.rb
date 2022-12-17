require 'cocos'



## our own code
require_relative 'ethname/version'
require_relative 'ethname/directory'


module Ethname

def self.dir
   @dir ||= Directory.read( "#{root}/config/contracts.2017.csv",
                            "#{root}/config/contracts.2021.csv",
                            "#{root}/config/contracts.2022.csv",
                            )
end
class << self
   alias_method :directory, :dir
end

def self.[]( q )
  dir[ q ]
end

end  # module Ethname



Ethname.banner   ## say hello