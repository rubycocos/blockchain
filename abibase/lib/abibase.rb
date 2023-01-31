################
#   download ABIs via Etherscan

require 'optparse'


require 'etherscan-lite'
require 'abidoc'
require 'solidity'



require_relative 'abibase/directory'


def format_code( txt )
  ##  {{ to {
  ## and }} to }
  txt = txt.strip.sub( /\A\{\{/, '{').sub( /\}\}\z/, '}' )

  data = JSON.parse( txt )
  ## pp data

  language = data['language']
  pp language
  if language != 'Solidity'
    puts "!! ERROR - expected Solidity for language; got: #{language}"
    exit 1
  end

  sources = data['sources']
  puts "  #{sources.size} source(s)"

  buf = ''
  sources.each do |name, h|
     buf << "///////////////////////////////////////////\n"
     buf << "// File: #{name}\n\n"
     buf << h['content']
     buf << "\n\n"
  end
  buf
end





class ContractDetailsCache

  def initialize( path )
    @path = path
    @table = if File.exist?( path )
                 build_table( read_csv( path ) )
             else
                 {}
             end
  end

  def [](addr)
     if @table.has_key?( addr )
         @table[ addr ]
     else  ## fetch missing data
        data = Etherscan.getcontractdetails( contractaddress: addr )
        ## note: add new data to cache
        @table[ addr ] = data
        data
     end
  end



  def build_table( recs )
    h = {}
    recs.each do |rec|
        ## (re)use contractdetails format / hash keys
        h[ rec['address'] ] = {
              'contractAddress' => rec['address'],
              'contractCreator' => rec['creator'],
              'txHash'          => rec['txid'],
              'blockNumber'     => rec['blocknumber'],
              'timestamp'       => rec['timestamp']
           }
    end
    h
  end

  def save
    ##############
    ## save cache - sort by blocknumber
    entries = @table.values.sort { |l,r| l['blockNumber'].to_i(16) <=> r['blockNumber'].to_i(16)  }
    buf = ''
    buf << ['blocknumber', 'timestamp', 'address', 'creator', 'txid'].join( ', ' )
    buf << "\n"
    entries.each do |entry|
       buf << [entry['blockNumber'],
               entry['timestamp'],
               entry['contractAddress'],
               entry['contractCreator'],
               entry['txHash']
               ].join( ', ' )
       buf << "\n"
    end
    write_text( @path, buf )
  end
end  # class  ContractDetailsCache







module Abi

class Tool

  def self.main( args=ARGV )
    puts "==> welcome to abibase tool with args:"
    pp args

    options = {}

    parser = OptionParser.new do |opts|
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

    command          = args[0] || 'add'

    if ['a', 'add'].include?( command )
      do_add
    elsif ['l', 'ls', 'list'].include?( command )
      do_list
    elsif ['d', 'dl', 'download'].include?( command )
      do_download_abis
    elsif ['code'].include?( command )
      do_download_code
    elsif ['doc', 'docs'].include?( command )
      do_generate_docs
    elsif ['t', 'time', 'timeline'].include?( command )
      do_generate_timeline   # & download contract details (txid,timestamp,etc.)
    else
      puts "!! ERROR - unknown command >#{command}<, sorry"
    end

    puts "bye"
  end


  def self.do_add
    puts "==> add abis..."

    recs = read_csv( "./contracts.csv" )
    puts "   #{recs.size} record(s)"
  end

  def self.do_list
    puts "==> list contracts..."

    #    recs = read_meta( "./address" )

    each_contract do |meta|
      puts "==> #{meta.addr}"

      print "  name: "
      puts  meta.name
      print "  names (#{meta.names.size}): "
      puts  meta.names.join(' | ' )

      print "  timestamp: "
      puts  meta.timestamp

      print "  created: "
      puts  meta.created

      print "  block: "
      puts  meta.block
      print "  txid: "
      puts  meta.txid
      print "  creator: "
      puts  meta.creator
    end
  end



  def self.do_download_abis
     puts "==> download abis..."

     recs = read_csv( "./contracts.csv" )
     puts "   #{recs.size} record(s)"

     delay_in_s = 1

     recs.each_with_index do |rec,i|
       addr  = rec['address'].downcase
       names = rec['names']
       puts "==> [#{i+1}/#{recs.size}] #{names} @ #{addr}..."

       outpath = "./address/#{addr}/abi.json"

       if File.exist?( outpath )
          # already download / found in cache
       else
         puts "  sleeping in #{delay_in_s} sec(s)..."
         sleep( delay_in_s )
         data = Etherscan.getabi( address: addr )
         pp data   ## note: returns abi data as a json string (parse again!!)
         abi = JSON.parse( data )
         pp abi

         write_json( outpath, abi )
       end
     end
  end




  def self.do_download_code
    puts "==> download (source) code..."

    recs = read_csv( "./contracts.csv" )
    puts "   #{recs.size} record(s)"

    delay_in_s = 1

    recs.each_with_index do |rec,i|
      addr  = rec['address'].downcase
      names = rec['names']
      puts "==> [#{i+1}/#{recs.size}] #{names} @ #{addr}..."

      outpath_code = "./address/#{addr}/contract.sol"
      outpath_meta = "./address/#{addr}/contract.yml"

      if File.exist?( outpath_code )
         # already download / found in cache
      else
        puts "  sleeping in #{delay_in_s} sec(s)..."
        sleep( delay_in_s )

        data = Etherscan.getsourcecode( address: addr )
        pp data   ## note: returns abi data as a json string (parse again!!)

        ## note: returns an array
        if data.size != 1
          puts "!! ERROR - expected array of size 1; got #{data.size}"
          exit 1
        end

        code = data[0]['SourceCode']

        ## note:  unroll multi-file format if present (starts with {{ .. }})
        code = format_code( code )   if code.start_with?( /[ \t\n\r]*\{\{/ )


        ## fix:  use "universal new line or such ?? - why lines get duplicated??"
        ##  hack: use write_blob
        write_blob( outpath_code, code )

        ## remove SourceCode & ABI entries
        data[0].delete('SourceCode')
        data[0].delete('ABI')
        puts "meta:"
        pp data[0]

        ##  save rest (remaining) as yml
        write_text( outpath_meta, YAML.dump( data[0] ))
      end
    end
  end

  def self.do_generate_docs
    puts "==> generate docs..."

    each_contract do |meta|

       addr = meta.addr
       ##  add solidity contract outline
       parser = Solidity::Parser.read( "./address/#{addr}/contract.sol" )

       buf = String.new( '' )
       buf << "Contract outline - [contract.sol](contract.sol):\n\n"
       buf << "```\n"
       buf << parser.outline
       buf << "```\n"
       buf << "\n\n"

       ## add some more metadata
       buf << "Created on Ethereum Mainnet:\n"
       buf << "- Block #{meta.block} @ #{meta.created} (#{meta.timestamp})\n"
       buf << "- Tx Id #{meta.txid}\n"
       buf << "- By #{meta.creator}\n"
       buf << "\n\n"


       abi = ABI.read( "./address/#{addr}/abi.json" )

       natspec =  if File.exist?( "./address/#{addr}/contract.md" )
                     Natspec.read( "./address/#{addr}/contract.md" )
                  else
                    nil
                  end

       buf << abi.generate_doc( title: "#{meta.names.join(' | ')} - Contract ABI @ #{addr}",
                                natspec: natspec )
       puts buf

       write_text( "./address/#{addr}/README.md", buf )

       buf =  abi.generate_interface( name: '' )    # solidity interface declarations (source code)
       write_text( "./address/#{addr}/interface.sol", buf )
    end
  end




  def self.do_generate_docs_old
    puts "==> generate docs..."

    paths = Dir.glob( "./address/**/abi.json" )
    ## paths = paths[0..2]
    paths.each do |path|
       basename = File.basename( File.dirname( path ))


       ##  add solidity contract outline
       parser = Solidity::Parser.read( "./address/#{basename}/contract.sol" )

       buf = String.new( '' )
       buf << "Contract outline:\n\n"
       buf << "```\n"
       buf << parser.outline
       buf << "```\n"
       buf << "(source: [contract.sol](contract.sol))\n"
       buf << "\n\n"


       abi = ABI.read( path )

       natspec =  if File.exist?( "./address/#{basename}/contract.md" )
                     Natspec.read( "./address/#{basename}/contract.md" )
                  else
                    nil
                  end

       buf << abi.generate_doc( title: "Contract ABI - #{basename}",
                                natspec: natspec )
       puts buf

       write_text( "./address/#{basename}/README.md", buf )

       buf =  abi.generate_interface( name: '' )    # solidity interface declarations (source code)
       write_text( "./address/#{basename}/interface.sol", buf )
    end
  end


  def self.do_generate_timeline
    puts "==> generate timeline..."

    ## collection all addresses
    addresses = []
    paths = Dir.glob( "./address/**/abi.json" )
    ## paths = paths[0..2]
    paths.each do |path|
       basename = File.basename( File.dirname( path ))

       addresses <<  basename.downcase
    end

    pp addresses
    puts "   #{addresses.size} record(s)"

    ## update contractdetails.csv
    ## build cache
    cache = ContractDetailsCache.new( './contractdetails.csv' )

    recs = []
    addresses.each_with_index do |addr,i|
       rec = cache[ addr ]
       recs << rec
    end
    ### note:  save back contractdetails cache
    cache.save

    ############
    ## sort by blocknumber  (reverse chronological)
    recs = recs.sort do |l,r|
                  l['blockNumber'].to_i(16) <=> r['blockNumber'].to_i(16)
                end

    pp recs

## create report / page
buf = <<TXT
#  Awesome (Ethereum) Contracts  / Blockchain Services

Cache of (ethereum) contract ABIs (application binary interfaces)
and  open source code (if verified / available)


TXT

meta = read_csv( './contracts.csv')
## build name lookup by address
contracts = meta.reduce( {} ) {|h,rec| h[rec['address']]=rec['names']; h }
pp contracts

recs.each_with_index do |rec,i|
  addr        = rec['contractAddress'].downcase
  timestamp   = rec['timestamp'].to_i(16)
  date = Time.at( timestamp).utc

  tooltip = date.strftime('%b %-d, %Y')

   names = contracts[addr]
   if names.nil?
    puts "!! ERROR: no name found for contract; sorry:"
    pp rec
    exit 1
   end

   names = names.split( '|' )
   names = names.map { |name| name.gsub( /[ \t]+/, ' ' ).strip }
   name  = names[0]

   buf << " · "  if i > 0
   buf << %Q{[#{name}](address/#{addr}  "#{tooltip}")}
   buf << "\n"
end


buf << "\n"
buf << "## Timeline\n\n"

recs.each do |rec|

  addr        = rec['contractAddress']
  creator     = rec['contractCreator']
  txid        = rec['txHash']
  blocknumber = rec['blockNumber'].to_i(16)
  timestamp   = rec['timestamp'].to_i(16)
  date = Time.at( timestamp).utc

  names = contracts[addr]
  if names.nil?
   puts "!! ERROR: no name found for contract; sorry:"
   pp rec
   exit 1
  end

  names = names.split( '|' )
  names = names.map { |name| name.gsub( /[ \t]+/, ' ' ).strip }
  name  = names[0]

  buf << "###  #{names.join( ' | ')} - #{date.strftime('%b %-d, %Y')}\n\n"

  buf << "contract @ [**#{addr}**](address/#{addr})"
  buf << " - [Etherscan](https://etherscan.io/address/#{addr})"
  buf << ", [Bloxy](https://bloxy.info/address/#{addr})"
 ## buf << ", [ABIDocs](https://abidocs.dev/contracts/#{addr})"
  buf << "\n\n"

#  buf << "created by [#{creator}](https://etherscan.io/address/#{creator}))"
#  buf << " at block no. #{blocknumber} (#{date})"
#  buf << " - txid [#{txid}](https://etherscan.io/tx/#{txid})"
#  buf << "\n\n"
end


write_text( './README.md', buf )





  end
end  # class Tool
end  # module Abi
