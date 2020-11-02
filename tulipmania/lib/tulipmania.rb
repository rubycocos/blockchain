# encoding: utf-8

# stdlibs
require 'json'
require 'digest'
require 'net/http'
require 'set'
require 'optparse'
require 'pp'


### 3rd party gems
require 'sinatra/base'                         # note: use "modular" sinatra app / service

require 'merkletree'
require 'blockchain-lite/proof_of_work/block'  # note: use proof-of-work block only (for now)


### our own code
require 'tulipmania/version'    ## let version always go first
require 'tulipmania/block'
require 'tulipmania/cache'
require 'tulipmania/transaction'
require 'tulipmania/blockchain'
require 'tulipmania/pool'
require 'tulipmania/exchange'
require 'tulipmania/ledger'
require 'tulipmania/wallet'

require 'tulipmania/node'
require 'tulipmania/service'

require 'tulipmania/tool'


module Tulipmania

  class Configuration
     ## user/node settings
     attr_accessor :address   ## single wallet address (for now "clear" name e.g. Anne, Vincent, etc.)

     WALLET_ADDRESSES = ['Anne', 'Vicent', 'Ruben', 'Julia', 'Luuk',
                         'Daisy', 'Max', 'Martijn', 'Naomi', 'Mina',
                         'Isabel'
                        ]

     ## system/blockchain settings
     attr_accessor :coinbase
     attr_accessor :mining_reward
     attr_accessor :tulips     ## rename to assets/commodities/etc. - why? why not?

     ## note: add a (†) coinbase / grower marker
     TULIP_GROWERS = ['Dutchgrown†', 'Keukenhof†', 'Flowers†',
                      'Bloom & Blossom†', 'Teleflora†'
                     ]

     TULIPS = ['Semper Augustus',
               'Admiral van Eijck',
               'Admiral of Admirals',
               'Red Impression',
               'Bloemendaal Sunset',
              ]

     def initialize
       ## try default setup via ENV variables
       ## pick "random" address if nil (none passed in)
       @address = ENV[ 'TULIPMANIA_NAME'] || rand_address()

       @coinbase      = TULIP_GROWERS   ## use a different name for coinbase - why? why not?
                                        ##  note: for now is an array (multiple growsers)

       @tulips        = TULIPS        ## change name to commodities or assets - why? why not?
       @mining_reward = 5
     end


     def rand_address()      WALLET_ADDRESSES[rand( WALLET_ADDRESSES.size )];  end
     def rand_tulip()        @tulips[rand( @tulips.size )];      end
     def rand_coinbase()     @coinbase[rand( @coinbase.size )];  end

     def coinbase?( address )    ## check/todo: use wallet - why? why not? (for now wallet==address)
       @coinbase.include?( address )
     end
  end # class Configuration


  ## lets you use
  ##   Tulipmania.configure do |config|
  ##      config.address = 'Anne'
  ##   end

  def self.configure
    yield( config )
  end

  def self.config
    @config ||= Configuration.new
  end


  ## add command line binary (tool) e.g. $ try centralbank -h
  def self.main
   Tool.new.run(ARGV)
  end
end # module Tulipmania



# say hello
puts Tulipmania::Service.banner
