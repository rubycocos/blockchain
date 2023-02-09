###
#  to run use
#     ruby -I ./lib sandbox/test_parse2.rb

$LOAD_PATH.unshift( "../abiparser/lib" )
require 'abi2sol'

names = [
  'AirSwap',
  'BunchaStructs',
]

names.each do |name|
  abi = ABI.read( "./abis//#{name}.abi.json" )
  pp abi

  buf =  abi.generate_interface( name: name )
  puts buf
  write_text( "./tmp/#{name}.sol", buf )
end


puts "bye"
