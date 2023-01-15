###
#  to run use
#     ruby  sandbox/generate.rb

$LOAD_PATH.unshift( "../abigen/lib" )
$LOAD_PATH.unshift( "../natspec/lib" )
require 'abigen'


recs = [
 ['mooncats',    'Mooncats',   '0x60cd862c9c687a9de49aecdc3a99b74a4fc54ab6'],
 ['phunks_v2',   'PhunksV2',   '0xf07468ead8cf26c752c676e43c814fee9c8cf402'],
 ['punks_data',  'PunksData',  '0x16f5a35647d6f03d5d3da7b35409d65ba03af3b2'],
 ['synth_punks', 'SynthPunks', '0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf'],
 ['moonbirds',   'Moonbirds',  '0x23581767a106ae21c074b2276d25e5c3e136a68b'],
 ['marcs',       'Marcs',      '0xe9b91d537c3aa5a3fa87275fbd2e4feaaed69bd0'],
 ['mad_camels',  'MadCamels',  '0xad8474ba5a7f6abc52708f171f57fefc5cdc8c1c' ],
]

recs.each do |name1, name2, address|
  abi = ABI.read( "../../awesome-contracts/address/#{address}/abi.json" )
  pp abi

  # natspec = Natspec.read( "../../awesome-contracts/address/#{punks_meta}/contract.md" )
  # pp natspec

  buf = abi.generate_code( name: name2,
                           address: address )
  write_text( "./lib/ethlite/contracts/#{name1}.rb", buf )
end



punks_meta   = '0xd8e916c3016be144eb2907778cf972c4b01645fC'

abi = ABI.read( "../../awesome-contracts/address/#{punks_meta}/abi.json" )
pp abi

natspec = Natspec.read( "../../awesome-contracts/address/#{punks_meta}/contract.md" )
pp natspec



buf = abi.generate_code( name: 'PunksMeta',
                         address: punks_meta,
                         natspec: natspec )
write_text( "./lib/ethlite/contracts/punks_meta.rb", buf )




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
