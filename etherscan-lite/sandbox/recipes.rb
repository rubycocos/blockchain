###
#  to run use
#     ruby -I ./lib sandbox/recipes.rb

require 'etherscan-lite'



## Get All USDT Transfers from Binance
##   see https://docs.etherscan.io/recipes/get-all-usdt-transfers-from-binance

USDT_ADDRESS = '0xdac17f958d2ee523a2206206994597c13d831ec7'
BINANCE_HOT_WALLET = '0xdfd5293d8e347dfe59e90efd55b2956a1343963d'

data = Etherscan.tokentx( address: BINANCE_HOT_WALLET,
                          contractaddress: USDT_ADDRESS )
pp data


##  One thing to note is the token value field is returned
##  in the token's smallest representation,
## you would have to divide this by the token decimal
## to get the transfer amount.
## An example value of 198000000000 would be represented
## as the transfer of 198000 USDT.
##

data.each_with_index do |h,i|
  timestamp =   Time.at( h['timeStamp'].to_i ).utc

  decimal = h['tokenDecimal'].to_i
  value = h['value'].to_i

  major = value / (10**decimal)
  minor = value % (10**decimal)

  print "  [#{i}] #{timestamp} -  "
  print "#{h['tokenName']} (#{h['tokenSymbol']}) "
  print "%6d.%0#{decimal}d" % [major, minor]
  print " (#{value}) - "
  print "from: #{h['from'][0..10]}  "
  print "to: #{h['to'][0..10]} - "
  print "txid: #{h['hash'][0..8]}"
  print "\n"
end


## Get the Latest Moonbird NFT Transfers
##  see https://docs.etherscan.io/recipes/get-the-latest-moonbird-nft-transfers

MOONBIRDS_ADDRESS = '0x23581767a106ae21c074b2276D25e5C3e136a68b'

data = Etherscan.tokennfttx( contractaddress: MOONBIRDS_ADDRESS )
pp data

data.each_with_index do |h,i|
  timestamp =   Time.at( h['timeStamp'].to_i ).utc

  print "  [#{i}] #{timestamp} -  "
  print "#{h['tokenName']} #{h['tokenID']} - "
  print "from: #{h['from'][0..10]}  "
  print "to: #{h['to'][0..10]} - "
  print "txid: #{h['hash'][0..8]}"
  print "\n"
end



## List ETH deposits to Arbitrum Bridge
##   see https://docs.etherscan.io/recipes/list-eth-deposits-to-arbitrum-bridge


ARBITRUM_DELAYED_INBOX = '0x4dbd4fc535ac27206064b68ffcf827b0a60bab3f'

data = Etherscan.txlist( address: ARBITRUM_DELAYED_INBOX )
pp data

data.each_with_index do |h,i|
  timestamp =   Time.at( h['timeStamp'].to_i ).utc

  ## note: ether (ETH) uses 18 decimal
                 ## e.g. 0.000000000000000001 (= 1 wei)
  decimal = 18
  value = h['value'].to_i

  major = value / (10**decimal)
  minor = value % (10**decimal)

  print "  [#{i}] #{timestamp} -  "
  print "#{h['functionName']} "
  print "%3d.%0#{decimal}d" % [major, minor]
  print " (#{value}) - "
  print "from: #{h['from'][0..10]}  "
  print "to: #{h['to'][0..10]} - "
  print "txid: #{h['hash'][0..8]}"
  print "\n"
end



puts "bye"



