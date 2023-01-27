##
#  check and auto-fill new contract candidates in inbox
#
#  to run use
#     ruby -I ./lib sandbox/inbox.rb


require_relative 'helper'

##  step 1:
## collect more metadata about (contract) address

## build cache
cache = ContractDetailsCache.new( './sandbox/contractdetails.csv' )


meta = []

recs = read_csv( './sandbox/inbox.csv' )
puts "   #{recs.size} record(s)"

recs.each_with_index do |rec,i|
  names = rec['names']
  addr  = rec['address'].downcase
  puts "==> [#{i+1}] #{names} @ #{addr}..."

  data = cache[ addr ]
  pp data

  timestamp = data['timestamp'].to_i(16)

  ## reformat to "classic format"
  ##   for date use "2022-02-03 08:49:52"
  meta << [addr, names, '',
            Time.at( timestamp ).utc.strftime( '%Y-%m-%d %H:%M:%S' )
           ]
end

### note:  save back contractdetails cache
cache.save


## (re)sort by timestamp / created date
meta  = meta.sort { |l,r| l[3] <=> r[3] }


## tddo - lint / warn about non-unique names if any!!!
##   todo - keep track of duplicate in new names too!!!


pp meta


meta.each do |values|
  names = values[1]
  rec = Ethname[ names ]
  if rec
    puts "!! WARN - duplicate contract found for >#{names}<:"
    pp rec
  end
end


headers = [
 'address',
 'names',
 'interfaces',
 'created'
]
###


buf = String.new('')
buf << headers.join( ', ')
buf << "\n"
meta.each do |values|
  buf << values.join( ', ' )
  buf << "\n"
end


write_text( "./tmp/contracts.csv", buf )

puts "bye"

__END__


[["0x22a81c80bb6bf4b797acf08351934b46193bddde", "novo", "", "2023-01-08 04:10:59 UTC"],
 ["0x897792d16a46f9e70446638bfc6a0d884b741f9b", "pepeburbpunks", "", "2023-01-10 13:36:47 UTC"],
 ["0x0e10e5e978ba4d1af92eb554cd730c9b97f4e571", "pepeblocks", "", "2023-01-14 05:37:35 UTC"],
 ["0x5a8e04a84fb2f6ad4002c824045c7c1bde10cb81", "frogcentral", "", "2023-01-17 03:42:35 UTC"],
 ["0xe302f509c4a3729791215f74299f1fa626396e5a", "gmkevin", "", "2023-01-19 00:24:35 UTC"],
 ["0xcce158dd5384b599fc29fe34d83b11ea8fb7a816", "deathofkevin", "", "2023-01-22 12:09:47 UTC"],
 ["0xb0dc51536e2b4950d7d6667748a6be6fc53c3318", "cutekevin", "", "2023-01-22 16:29:35 UTC"],
 ["0x94cb646dd34b3b0ff7c116208f7f7ff7ac216079", "ecc0s", "", "2023-01-25 12:38:11 UTC"],
 ["0xe6313d1776e4043d906d5b7221be70cf470f5e87", "shiba", "", "2023-01-26 02:20:47 UTC"]]