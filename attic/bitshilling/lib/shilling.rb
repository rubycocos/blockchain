# encoding: utf-8

# stdlibs
require 'json'
require 'digest'
require 'net/http'
require 'set'
require 'pp'
require 'optparse'    ## note: used for command line tool (see Tool in tool.rb)


### 3rd party gems
require 'sinatra/base'                         # note: use "modular" sinatra app / service


require 'blockchain-lite/base'

###
#  add convenience top-level shortcut / alias
#    "standard" default block for now block with proof of work
Block   = BlockchainLite::ProofOfWork::Block


require 'ledger-lite/base'

###
# add convenience top-level shortcut / alias
Ledger = LedgerLite::Ledger



### our own code
require 'shilling/version'    ## let version always go first
require 'shilling/block'
require 'shilling/cache'
require 'shilling/transaction'
require 'shilling/blockchain'
require 'shilling/pool'
require 'shilling/bank'
require 'shilling/wallet'

require 'shilling/node'
require 'shilling/service'

require 'shilling/tool'    ## add (optional) command line tool





module Shilling


  class Configuration
     ## user/node settings
     attr_accessor :address   ## single wallet address (for now "clear" name e.g.Sepp, Franz, etc.)

     WALLET_ADDRESSES = %w[Theresa Franz Antonia Maximilan Maria Ferdinand Elisabeth Adam Eva]

     ## system/blockchain settings
     attr_accessor :coinbase
     attr_accessor :mining_reward

     ## note: add a (†) coinbase  marker
     ##  fix: "sync" with ledger-lite config!!!!
     COINBASE = ['Coinbase†']
=begin
     COINBASE = ['Großglockner†', 'Wildspitze†', 'Großvenediger†',
                 'Hochfeiler†', 'Zuckerhütl†', 'Hochalmspitze†',
                 'Gr. Muntanitz†', 'Hoher Riffler†',
                 'Parseierspitze†', 'Hoher Dachstein†'
                ]
=end


     def initialize
       ## try default setup via ENV variables
       ## pick "random" address if nil (none passed in)
       @address = ENV[ 'SHILLING_NAME'] || rand_address()

       @coinbase = COINBASE         ## use a different name - why? why not?
                                    ##  note: for now is an array (multiple coinbases)
       @mining_reward = 43     ## use country code for austria (43)
     end

     def rand_address()      WALLET_ADDRESSES[rand( WALLET_ADDRESSES.size )];  end
     def rand_coinbase()     @coinbase[rand( @coinbase.size )];  end

     def coinbase?( address )    ## check/todo: use wallet - why? why not? (for now wallet==address)
       @coinbase.include?( address )
     end

  end # class Configuration


  ## lets you use
  ##   Shilling.configure do |config|
  ##      config.address = 'Sepp'
  ##   end

  def self.configure
    yield( config )
  end

  def self.config
    @config ||= Configuration.new
  end


  ## add command line binary (tool) e.g. $ try shilling -h
  def self.main
   Tool.new.run(ARGV)
  end

end # module Shilling


# say hello
puts Shilling::Service.banner
