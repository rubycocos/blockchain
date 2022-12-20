################
#   download ABIs via Etherscan

#
#  to run use
#     ruby sandbox/download_abis.rb


$LOAD_PATH.unshift( "../etherscan-lite/lib" )
require 'ethname'
require 'etherscan-lite'



puts "  #{Ethname.directory.size} (contract) address record(s)"


delay_in_s = 1

Ethname.directory.records.each_with_index do |rec,i|
  puts "==> [#{i+1}] #{rec.names.join('|')} @ #{rec.addr} supports #{rec.interfaces.join('|')}..."

  outpath = "./abis/#{rec.addr}.json"

  if File.exist?( outpath )
     # already download / found in cache
  else
    puts "  sleeping in #{delay_in_s} sec(s)..."
    sleep( delay_in_s )
    data = Etherscan.getabi( address: rec.addr )
    pp data   ## note: returns abi data as a json string (parse again!!)
    abi = JSON.parse( data )
    pp abi

    write_json( outpath, abi )
  end
end



puts "bye"
