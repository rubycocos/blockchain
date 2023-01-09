#  Eth(ereum) Lite


ethlite -  light-weight machinery to query / call ethereum (blockchain contract) services via json-rpc (incl. tuple support)


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/ethlite](https://rubygems.org/gems/ethlite)
* rdoc  :: [rubydoc.info/gems/ethlite](http://rubydoc.info/gems/ethlite)



## Usage


### Step 0:  Setup JSON RPC Client

Let's use the simple (built-in) JSON RPC client.
Get the eth node uri via the INFURA_URI enviroment variable / key e.g.  `https://mainnet.infura.io/v3/<YOUR_KEY_HERE>`:

```ruby
ETH_NODE  = JsonRpc.new( ENV['INFURA_URI'] )
```



###  Do-It-Yourself (DIY) JSON RPC eth_call  With "Hand-Coded" To-The-Metal ABI Encoding/Decoding


Let's try to build a JSON-RPC request from scratch calling
a (constant/read-only/view) blockchain contract method via `eth_call`.

Let's try `function tokenURI(uint256 tokenId) returns (string)`
that lets you request the metdata uri for a (non-fungible) token.

Let's try the Moonbirds contract @  [0x23581767a106ae21c074b2276d25e5c3e136a68b](https://etherscan.io/address/0x23581767a106ae21c074b2276d25e5c3e136a68b):

```ruby
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
```


And the "magic"  hand-coded to-the-metal `eth_call` machinery:

```ruby
## construct a json-rpc call from scratch
def eth_call( rpc,
              contract_address,
              name, inputs, outputs,
              args )

  ## binary encode method sig(nature)
  signature      = "#{name}(#{inputs.join(',')})"
  signature_hash =  Ethlite::Utils.encode_hex(
                        Ethlite::Utils.keccak256(signature)[0,4])

  pp signature
  # => "tokenURI(uint256)"
  pp signature_hash
  # => "c87b56dd"

  ## binary encode method arg(ument)s
  args_encoded = Ethlite::Utils.encode_hex(
                   ABI.encode( inputs, args) )

  data = '0x' + signature_hash + args_encoded

  ## json-rpc  method and params
  method =  'eth_call'
  params =  [{ to:   contract_address,
              data: data},
            'latest'
            ]

  ## do the json-rpc request
  response = rpc.request( method, params )

  puts "response:"
  pp response

  ## decode binary result (returned as a hex string starting with 0x)
  bin = Ethlite::Utils.decode_hex( response )
  result =  ABI.decode( outputs, bin )
  result.length  == 1 ? result[0] : result
end
```

resulting in (with debug json rpc request/reponse output):


calling `tokenURI(0)`...  json_rpc POST payload request:

``` json
{"jsonrpc":"2.0",
 "method":"eth_call",
 "params":[
    {"to":"0x23581767a106ae21c074b2276d25e5c3e136a68b",
     "data":"0xc87b56dd0000000000000000000000000000000000000000000000000000000000000000"},
    "latest"],
  "id":1
}
```

json_rpc response:

``` json
{"jsonrpc":"2.0",
 "id":1,"result":"0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003a68747470733a2f2f6c6976652d2d2d6d657461646174612d35636f767071696a61612d75632e612e72756e2e6170702f6d657461646174612f30000000000000"
}
```

...returns: `https://live---metadata-5covpqijaa-uc.a.run.app/metadata/0`


calling `tokenURI(1)...`  json_rpc POST payload request:

``` json
{"jsonrpc":"2.0",
 "method":"eth_call",
 "params":[
  {"to":"0x23581767a106ae21c074b2276d25e5c3e136a68b",
   "data":"0xc87b56dd0000000000000000000000000000000000000000000000000000000000000001"},
   "latest"],
  "id":2
}
```

json_rpc response:

``` json
{"jsonrpc":"2.0",
 "id":2,"result":"0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003a68747470733a2f2f6c6976652d2d2d6d657461646174612d35636f767071696a61612d75632e612e72756e2e6170702f6d657461646174612f31000000000000"
}
```

...returns: `https://live---metadata-5covpqijaa-uc.a.run.app/metadata/1`



### JSON RPC eth_call With ContractMethod Helper

Let's retry using the convenience builtin
`ContractMethod` helper:

```ruby
## contract address - let's try moonbirds
contract_address = '0x23581767a106ae21c074b2276d25e5c3e136a68b'

ETH_tokenURI = Ethlite::ContractMethod.new( 'tokenURI',
                                             inputs: ['uint256'],
                                             outputs: ['string'] )

token_ids = (0..9)
token_ids.each do |token_id|
  puts "==> tokenURI(#{token_id}) returns:"
  pp ETH_tokenURI.do_call( ETH_NODE, contract_address, [token_id] )
end
```

resulting in:

```
==> tokenURI(0) returns:
"https://live---metadata-5covpqijaa-uc.a.run.app/metadata/0"
==> tokenURI(1) returns:
"https://live---metadata-5covpqijaa-uc.a.run.app/metadata/1"
==> tokenURI(2) returns:
"https://live---metadata-5covpqijaa-uc.a.run.app/metadata/3"
...
```


And so on and so forth.




## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.

