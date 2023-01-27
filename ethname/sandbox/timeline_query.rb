###
#  use etherscan api to lint / check-up on contract addresses
#     (and get creation timestamp etc.)
#
#  to run use
#     ruby -I ./lib sandbox/timeline_query.rb


require_relative 'helper'

##  step 1:
## collect more metadata about (contract) address

## build cache
cache = ContractDetailsCache.new( './sandbox/contractdetails.csv' )


Ethname.directory.records.each_with_index do |rec,i|
  puts "==> [#{i+1}] #{rec.names.join('|')} @ #{rec.addr} supports #{rec.interfaces.join('|')}..."

  data = cache[ rec.addr ]
   pp data
end


### note:  save back contractdetails cache
cache.save


puts "bye"

