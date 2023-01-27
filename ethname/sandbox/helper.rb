$LOAD_PATH.unshift( "../etherscan-lite/lib" )

require 'ethname'
require 'etherscan-lite'

puts "  #{Ethname.directory.size} (contract) address record(s)"



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

