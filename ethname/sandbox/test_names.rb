###
#  to run use
#     ruby -I ./lib sandbox/test_names.rb

require 'ethname'



pp Ethname.dict.recs
puts "  #{Ethname.dict.size} (contract) address record(s)"


pp Ethname.lookup( 'PUNKS V2' )
pp Ethname.lookup( 'Punks V.2' )
pp Ethname.lookup( '404 NOT FOUND' )

pp Ethname[ 'PUNKS V2' ]
pp Ethname[ 'Punks V.2' ]
pp Ethname[ '404 NOT FOUND']

pp Ethname[ 'PHUNKS' ]
pp Ethname[ 'SYNTHPUNKS' ]
pp Ethname[ 'PUNKBLOCKS' ]
pp Ethname[ 'MOONBIRDS' ]


puts
pp Ethname['punks v1']
pp Ethname['punks v2']
pp Ethname['punks v3']
pp Ethname['punks v4']

pp Ethname['punks v1 wrapped i']
pp Ethname['punks v1 wrapped ii']

pp Ethname['phunks v1']
pp Ethname['phunks v2']
pp Ethname['phunks v3']

pp Ethname['synth punks']

pp Ethname['punks data']
pp Ethname['punk blocks']



puts "bye"