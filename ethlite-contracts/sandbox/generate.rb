###
#  to run use
#     ruby  sandbox/generate.rb

$LOAD_PATH.unshift( "../abigen/lib" )
require 'abigen'

punks_v1    = '0x6ba6f2207e343923ba692e5cae646fb0f566db8d'

abi = ABI.read( "../test/address/#{punks_v1}.json" )
pp abi


buf = abi.generate_code( name: 'PunksV1',
                         address: punks_v1 )
write_text( "./lib/ethlite/contracts/punks_v1.rb", buf )




punk_blocks = '0x58e90596c2065befd3060767736c829c18f3474c'

abi = ABI.read( "../test/address/#{punk_blocks}.json" )
pp abi

buf =  abi.generate_code( name: 'PunkBlocks',
                          address: punk_blocks )
write_text( "./lib/ethlite/contracts/punk_blocks.rb", buf )

puts "bye"
