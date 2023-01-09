###
#  to run use
#     ruby -I ./lib sandbox/test_call.rb



require 'ethlite/contracts'




punksv1 = PunksV1.new     ## note: will use default (eth main network) contract address


pp punksv1


pp punksv1.name
pp punksv1.symbol
pp punksv1.numberOfPunksReserved
pp punksv1.totalSupply
pp punksv1.imageHash
pp punksv1.balanceOf( '0x0000000000000000000000000000000000000000' )


punkblocks = PunkBlocks.new   ## note: will use default (eth main network) contract address


pp punkblocks.getBlocks( 0, 1 )  ## _fromID, _count



puts "bye"
