###
#  to run use
#     ruby -I ./lib sandbox/test_parse.rb

require 'abiparser'


punks_v1    = '0x6ba6f2207e343923ba692e5cae646fb0f566db8d'
punk_blocks = '0x58e90596c2065befd3060767736c829c18f3474c'

abi = ABI.read( "../test/address/#{punks_v1}.json" )
pp abi

buf =  abi.generate_interface( name: 'PunksV1' )
puts buf
write_text( "./tmp/punks_v1.sol", buf )



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



abi = ABI.read( "../test/address/#{punk_blocks}.json" )
pp abi

buf = abi.generate_interface( name: 'PunkBlocks' )
puts buf
write_text( "./tmp/punk_blocks.sol", buf )


puts "selectors:"
pp abi.selectors



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



sig = 'supportsInterface(bytes4)'
pp keccak256( sig ).hexdigest


puts "bye"
