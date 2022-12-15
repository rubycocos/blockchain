###
#  to run use
#     ruby -I ./lib sandbox/query.rb

require 'etherscan-lite'


PUNKS_ADDRESS = '0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb'
MOONBIRDS_ADDRESS = '0x23581767a106ae21c074b2276D25e5C3e136a68b'

address = '0x7174039818a41E1ae40FDcFA3E293b0f41592AF2'


pp Etherscan.config.key

pp Etherscan.txlist_url( address: address )
# data = Etherscan.txlist( address: address )
# pp data


pp Etherscan.tokentx_url( address: address,
                          contractaddress: PUNKS_ADDRESS )

# data = Etherscan.tokentx( address: address, contractaddress: PUNKS_ADDRESS )
# pp data

data = Etherscan.tokentx( contractaddress: PUNKS_ADDRESS )
pp data

# data = Etherscan.tokentx( address: address )
# pp data


pp Etherscan.tokennfttx_url( contractaddress: MOONBIRDS_ADDRESS )
## data = Etherscan.tokennfttx( contractaddress: MOONBIRDS_ADDRESS )
## pp data



puts "bye"