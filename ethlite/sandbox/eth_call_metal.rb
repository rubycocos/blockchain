$LOAD_PATH.unshift( "../abicoder/lib" )
$LOAD_PATH.unshift( "./lib" )
require 'ethlite'


## note: to turn on debugging output use
##   Ethlite.config.debug = true
##   JsonRpc.debug = true


## construct a json-rpc call
def eth_call( rpc,
              contract_address,
              name, inputs, outputs,
              args )

  ## binary encode method sig(nature)
  signature      = "#{name}(#{inputs.join(',')})"
  signature_hash =  Ethlite::Utils.encode_hex(
                        Ethlite::Utils.keccak256(signature)[0,4])

  pp signature
  pp signature_hash

  ## binary encode method arg(ument)s
  args_encoded = Ethlite::Utils.encode_hex(
                   ABI.encode( inputs, args) )

  data = '0x' + signature_hash + args_encoded


  method =  'eth_call'
  params =  [{ to:   contract_address,
              data: data},
            'latest'
            ]

  response = rpc.request( method, params )

  puts "response:"
  pp response

  bin = Ethlite::Utils.decode_hex( response )
  result = ABI.decode( outputs, bin )
  result.length  == 1 ? result[0] : result
end




ETH_NODE  = JsonRpc.new( ENV['INFURA_URI'] )

## contract address - let's try moonbirds
contract_address = '0x23581767a106ae21c074b2276d25e5c3e136a68b'


# token_ids = (0..9)

# token_ids = (0..9)
token_ids = [0,1,2,3,4,5,7,8]

## check token no. 6 & 9 for moonbirds - is now on-chain????
token_ids.each do |token_id|

  puts "==> calling tokenURI(#{token_id})..."
  tokenURI = eth_call( ETH_NODE, contract_address,
                         'tokenURI', ['uint256'], ['string'],
                         [token_id] )
  puts "   ...returns: #{tokenURI}"
end


puts "bye"

