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

 ['nouns_descriptor',    'NounsDescriptor',   '0x0cfdb3ba1694c2bb2cfacb0339ad7b1ae5932b63'],
  ['nouns_seeder',        'NounsSeeder',       '0xcc8a0fb5ab3c7132c1b2a0109142fb112c4ce515'],
  ['nouns',               'Nouns',             '0x9c8ff314c9bc7f6e59a9d9225fb22946427edc03'],
  ['nouns_auction_house', 'NounsAuctionHouse', '0xf15a943787014461d94da08ad4040f79cd7c124e'],

  ['nouns_descriptor_v2', 'NounsDescriptorV2', '0x6229c811d04501523c6058bfaac29c91bb586268'],
  ['synth_nouns',         'SynthNouns',        '0x8761b55af5a703d5855f1865db8fe4dd18e94c53'],
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
