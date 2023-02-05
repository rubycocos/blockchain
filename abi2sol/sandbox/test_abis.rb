###
#  to run use
#     ruby -I ./lib sandbox/test_abis.rb

$LOAD_PATH.unshift( "../abiparser/lib" )
require 'abi2sol'

# name = 'AirSwap'
name = 'UniswapV2Router02'

abi = ABI.read( "./abis/#{name}.abi.json" )
## pp abi


buf =  abi.generate_interface( name: name )
puts buf

write_text( "./tmp/#{name}.sol", buf )




puts "bye"
