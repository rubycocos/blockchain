require 'ethlite'
require 'optparse'


## our own code
require_relative 'ethq/contract'




module EthQ

class Tool

  def self.main( args=ARGV )
    puts "==> welcome to ethq tool with args:"
    pp args

    options = {
              }

    parser = OptionParser.new do |opts|

      opts.on("--rpc STRING",
              "JSON RPC Host (default: nil)") do |str|
          options[ :rpc]  = str
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    parser.parse!( args )
    puts "options:"
    pp options

    puts "args:"
    pp args

    if args.size < 1
      puts "!! ERROR - no contract found - use <contract> <command>..."
      puts ""
      exit
    end


    contract_address = args[0]
    command          = args[1] || 'token'


    if ['t','token', 'tokens'].include?( command )
        do_token( contract_address )
    else
      puts "!! ERROR - unknown command >#{command}<, sorry"
    end

    puts "bye"
  end



  def self.do_token( contract_address )
    puts "==> query token contract @ >#{contract_address}<:"

    c = Contract.new( contract_address )

    name         =  c.name
    symbol       =  c.symbol
    totalSupply  =  c.totalSupply

    puts "   name: >#{name}<"
    puts "   symbol: >#{symbol}<"
    puts "   totalSupply: >#{totalSupply}<"
  end


end  # class Tool
end   # module EthQ




######
#  add convience alternate spelling / names
Ethq  = EthQ

