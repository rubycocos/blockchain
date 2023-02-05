require 'cocos'


names = [
  'AirSwap',
  'BunchaStructs',
  'DepositContract',
  'ENS',
  'UniswapV2Router02',
]


names.each do |name|
   data = read_json( "./abis/#{name}.abi.json" )
   buf = YAML.dump( data )
   ## puts buf
   write_text( "./abis/#{name}.abi.yml", buf )
end

puts "bye"