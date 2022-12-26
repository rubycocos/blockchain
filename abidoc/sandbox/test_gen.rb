###
#  to run use
#     ruby -I ./lib sandbox/test_gen.rb

require 'abidoc'


abi = ABI.read( '../abiparser/test/data/0x6ba6f2207e343923ba692e5cae646fb0f566db8d.json' )
pp abi

puts abi.generate_doc( title: 'Contract ABI for CryptoPunks' )


puts "bye"
