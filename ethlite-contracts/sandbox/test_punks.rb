###
#  to run use
#     ruby -I ./lib sandbox/test_punks.rb



require 'ethlite/contracts'


###############################
# try Punks V1 contract
punksv1 = PunksV1.new     ## note: will use default (eth main network) contract address

pp punksv1


pp punksv1.name
pp punksv1.symbol
pp punksv1.numberOfPunksReserved
pp punksv1.totalSupply
pp punksv1.imageHash
pp punksv1.balanceOf( '0x0000000000000000000000000000000000000000' )


##################################
# try Punk Blocks contract
punkblocks = PunkBlocks.new   ## note: will use default (eth main network) contract address


pp punkblocks.getBlocks( 0, 1 )  ## _fromID, _count



############################
# try Punks Meta contract

punksmeta = PunksMeta.new

tokenId = 0
pp punksmeta.parseAttributes( tokenId )
pp punksmeta.getAttributes( tokenId )
pp punksmeta.tokenURI( tokenId )


############################
# try Punks Data contract
punksdata = PunksData.new

tokenId = 0
pp punksdata.punkAttributes( tokenId )
pp punksdata.punkImage( tokenId )
pp punksdata.punkImageSvg( tokenId )


puts "bye"
