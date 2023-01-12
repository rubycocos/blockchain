###
#  to run use
#     ruby -I ./lib sandbox/test_parse.rb

require 'natspec'

punks_v1    = '0x6ba6f2207e343923ba692e5cae646fb0f566db8d'

nat =  Natspec.read( "../../awesome-contracts/address/#{punks_v1}/contract.md" )
pp nat



punk_blocks = '0x58e90596c2065befd3060767736c829c18f3474c'

nat = Natspec.read( "../../awesome-contracts/address/#{punk_blocks}/contract.md" )
pp nat


puts "bye"
