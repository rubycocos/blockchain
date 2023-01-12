###
#  to run use
#     ruby  sandbox/generate.rb

$LOAD_PATH.unshift( "../abigen/lib" )
$LOAD_PATH.unshift( "../natspec/lib" )
require 'abigen'


punks_v1    = '0x6ba6f2207e343923ba692e5cae646fb0f566db8d'


abi = ABI.read( "../../awesome-contracts/address/#{punks_v1}/abi.json" )
pp abi

natspec = Natspec.read( "../../awesome-contracts/address/#{punks_v1}/contract.md" )
pp natspec



buf = abi.generate_code( name: 'PunksV1',
                         address: punks_v1,
                         natspec: natspec )
write_text( "./lib/ethlite/contracts/punks_v1.rb", buf )




punk_blocks = '0x58e90596c2065befd3060767736c829c18f3474c'

abi = ABI.read( "../../awesome-contracts/address/#{punk_blocks}/abi.json" )
pp abi

natspec = Natspec.read( "../../awesome-contracts/address/#{punk_blocks}/contract.md" )
pp natspec


buf =  abi.generate_code( name: 'PunkBlocks',
                          address: punk_blocks,
                          natspec: natspec )
write_text( "./lib/ethlite/contracts/punk_blocks.rb", buf )

puts "bye"
