###
#  to run use
#     ruby -I ./lib sandbox/test_names.rb

require 'ethname'



pp Ethname.directory.records
puts "  #{Ethname.directory.size} (contract) address record(s)"


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



pp rec = Ethname::Record.find( '0xaf9CE4B327A3b690ABEA6F78eCCBfeFFfbEa9FDf' )
pp rec.addr
pp rec.address
pp rec.name
pp rec.names

pp rec = Ethname::Record.find_by( name: 'synth punks' )


puts "bye"