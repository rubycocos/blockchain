###
#  to run use
#     ruby -I ./lib sandbox/test_parse.rb

require 'abiparser'


abi = ABI.read( './test/data/0x6ba6f2207e343923ba692e5cae646fb0f566db8d.json' )
pp abi

puts abi.generate_interface( name: 'CryptoPunks' )


puts "selectorrs:"
pp abi.selectors


puts "supports name():"
pp abi.support?( 'name()' )
pp abi.support?( 'name( )' )
pp abi.support?( '0x06fdde03' )
pp abi.support?( '0x06FDDE03' )
pp abi.support?( '06fdde03' )
pp abi.support?( '06FDDE03' )


puts "supports symbol():"
pp abi.support?( 'symbol()' )

puts "supports tokenURI(uint256):"
pp abi.support?( 'tokenURI(uint256)' )



pp IERC20
pp IERC20.interface_id
pp IERC20.calc_interface_id

pp IERC20.support?( 'balanceOf(address)' )
pp IERC20.support?( 'name( )' )


pp IERC721
pp IERC721.interface_id
pp IERC721.calc_interface_id

pp IERC721.support?( 'balanceOf(address)' )
pp IERC721.support?( 'name( )' )


puts "bye"
