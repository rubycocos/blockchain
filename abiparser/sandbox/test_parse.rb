###
#  to run use
#     ruby -I ./lib sandbox/test_parse.rb

require 'abiparser'


abi = ABI.read( './test/data/0x6ba6f2207e343923ba692e5cae646fb0f566db8d.json' )
pp abi

puts abi.generate_interface( name: 'CryptoPunks' )


puts "bye"
