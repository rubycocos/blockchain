$LOAD_PATH.unshift( "../abicoder/lib" )
$LOAD_PATH.unshift( "./lib" )
require 'ethlite'



ETH_NODE  = JsonRpc.new( ENV['INFURA_URI'] )



## contract address - let's try moonbirds
contract_address = '0x23581767a106ae21c074b2276d25e5c3e136a68b'




ETH_tokenURI = Ethlite::ContractMethod.new( 'tokenURI',
                                             inputs: ['uint256'],
                                             outputs: ['string'] )

# token_ids = (0..9)
token_ids = [0,1,2,3,4,5,7,8]

## check token no. 6 & 9 for moonbirds - is now on-chain????
token_ids.each do |token_id|
  puts "==> tokenURI(#{token_id}) returns:"
  pp ETH_tokenURI.do_call( ETH_NODE, contract_address, [token_id] )
end


puts "bye"
