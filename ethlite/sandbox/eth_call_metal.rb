$LOAD_PATH.unshift( "./lib" )
require 'ethlite'




## construct a json-rpc call
def eth_call( rpc,
              contract_address,
              name, inputs, outputs,
              args )

  ## binary encode method sig(nature)
  signature      = "#{name}(#{inputs.join(',')})"
  signature_hash =  Ethlite::Utils.encode_hex(
                        Ethlite::Utils.keccak256(signature))[0..7]

  pp signature
  pp signature_hash

  ## binary encode method arg(ument)s
  args_encoded = Ethlite::Utils.encode_hex(
                   Ethlite::Abi.encode_abi( inputs, args) )

  data = '0x' + signature_hash + args_encoded


  method =  'eth_call'
  params =  [{ to:   contract_address,
              data: data},
            'latest'
            ]

  response = rpc.request( method, params )

  puts "response:"
  pp response

  string_data = Ethlite::Utils.decode_hex(
                     Ethlite::Utils.remove_0x_head(response))
  result = Ethlite::Abi.decode_abi( outputs, string_data )
  result.length  == 1 ? result[0] : result
end




ETH_NODE  = JsonRpc.new( ENV['INFURA_URI'] )

## contract address - let's try moonbirds
contract_address = '0x23581767a106ae21c074b2276d25e5c3e136a68b'


token_ids = (0..9)
token_ids.each do |token_id|

  puts "==> calling tokenURI(#{token_id})..."
  tokenURI = eth_call( ETH_NODE, contract_address,
                         'tokenURI', ['uint256'], ['string'],
                         [token_id] )
  puts "   ...returns: #{tokenURI}"
end


puts "bye"

