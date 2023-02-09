require 'abiparser'
require 'optparse'



##  our own code
require_relative 'abi2sol/model'
require_relative 'abi2sol/generate'




module Abi2Sol
class Tool

  def self.main( args=ARGV )
    puts "==> welcome to abi2parse tool with args:"
    pp args

    options = {
              }

    parser = OptionParser.new do |opts|

      opts.on("--name STRING",
              "name of contract interface (default: nil)") do |str|
          options[ :name]  = str
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
      puts "!! ERROR - no contract found - use <contract>"
      puts ""
      exit
    end

    path = args[0]

    do_generate( path, name: options[:name] )

    puts "bye"
  end



  def self.do_generate( path, name:  )
    abi = ABI.read( path )
    ## pp abi

    puts "==> generate contract interface from abi in (#{path})..."

    buf =  abi.generate_interface( name: name )
    puts buf
    ## write_text( "./tmp/punks_v1.sol", buf )
  end


end  # class Tool
end   # module Abi2Sol



######
#  add convience alternate spelling / names
Abi2sol       = Abi2Sol
Abi2solidity  = Abi2Sol
Abi2Solidity  = Abi2Sol

AbiToSol      = Abi2Sol
AbiToSolidity = Abi2Sol

