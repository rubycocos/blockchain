###
#  to run use
#     ruby -I ./lib sandbox/test_gen.rb

require 'abidoc'

punks_v1    = '0x6ba6f2207e343923ba692e5cae646fb0f566db8d'

abi = ABI.read( "../test/address/#{punks_v1}.json" )
pp abi

buf = abi.generate_doc( title: 'Contract ABI for Punks V1' )
write_text( "./tmp/punks_v1.md", buf )


punk_blocks = '0x58e90596c2065befd3060767736c829c18f3474c'

abi = ABI.read( "../test/address/#{punk_blocks}.json" )
pp abi

buf =  abi.generate_doc( title: 'Contract ABI for PunkBlocks' )
write_text( "./tmp/punk_blocks.md", buf )

puts "bye"
