# Etherscan Lite

etherscan-lite - light-weight machinery / helper for the Etherscan (blockchain) JSON HTTP API / web services (note: API key sign-up required)

* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/etherscan-lite](https://rubygems.org/gems/etherscan-lite)
* rdoc  :: [rubydoc.info/gems/etherscan-lite](http://rubydoc.info/gems/etherscan-lite)



## Usage


### Step 0 - Setup - Configure ETHERSCAN API Key


The etherscan lite machinery will (auto-magically) lookup
the `ETHERSCAN_KEY` environment variable
or will load a dotenv file (`.env`) in the working / current directory
or use in your script:

``` ruby
Etherscan.config.key = 'YOUR_API_KEY_HERE'

# or

Etherscan.configure do |config|
  config.key = 'YOUR_API_KEY_HERE'
end
```


### Etherscan API Recipes

Let's try the "official" recipes from the Eherscan API docu

- Get All USDT Transfers from Binance
- Get the Latest Moonbird Non-Fungible Token (NFT) Transfers
- List ETH deposits to Arbitrum Bridge


### Get All USDT Transfers from Binance

see <https://docs.etherscan.io/recipes/get-all-usdt-transfers-from-binance>


``` ruby
require 'etherscan-lite'

USDT_ADDRESS       = '0xdac17f958d2ee523a2206206994597c13d831ec7'
BINANCE_HOT_WALLET = '0xdfd5293d8e347dfe59e90efd55b2956a1343963d'

data = Etherscan.tokentx( address: BINANCE_HOT_WALLET,
                          contractaddress: USDT_ADDRESS )
pp data
```

resulting in:

``` json
[{"blockNumber": "16191306",
  "timeStamp": "1671121931",
  "hash": "0x77361870fdc3046f7c24cabafa7185a84d60f4fa12aef8363e8520fbdd003cc7",
  "nonce": "4866500",
  "blockHash": "0x1f5d2e10774bd5473257ad0f47d08b3e523e3baace6f0218bce8aab62e90ec67",
  "from": "0xdfd5293d8e347dfe59e90efd55b2956a1343963d",
  "contractAddress": "0xdac17f958d2ee523a2206206994597c13d831ec7",
  "to": "0x40fbc37ff0e4d3f900b867f2ca48ae6aba77c854",
  "value": "495264069",
  "tokenName": "Tether USD",
  "tokenSymbol": "USDT",
  "tokenDecimal": "6",
  "transactionIndex": "44",
  "gas": "207128",
  "gasPrice": "31567202036",
  "gasUsed": "63197",
  "cumulativeGasUsed": "5207555",
  "input": "deprecated",
  "confirmations": "3"},
 {"blockNumber": "16191304",
  "timeStamp": "1671121907",
  "hash": "0xd3d529d0d420e38680ad9066a5d62434a04b01e94b00b81fc5fea303afbda076",
  "nonce": "4866498",
  "blockHash": "0x9b2dfbfd068c90546c7572bc059cd790e12eb6b9f9b21a3c7c33e0abd8d69d6c",
  "from": "0xdfd5293d8e347dfe59e90efd55b2956a1343963d",
  "contractAddress": "0xdac17f958d2ee523a2206206994597c13d831ec7",
  "to": "0xf7140bb010da74a191e3c98f801e596937f177fb",
  "value": "4496800000",
  "tokenName": "Tether USD",
  "tokenSymbol": "USDT",
  "tokenDecimal": "6",
  "transactionIndex": "57",
  "gas": "207128",
  "gasPrice": "32759178674",
  "gasUsed": "46109",
  "cumulativeGasUsed": "3775818",
  "input": "deprecated",
  "confirmations": "5"},
  ...
]
```

and let's pretty print the data (records):

``` ruby
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
```

resulting in:

```
[0] 2022-12-15 16:32:11 UTC -  Tether USD (USDT)    495.264069 (495264069) - from: 0xdfd5293d8  to: 0x40fbc37ff - txid: 0x7736187
[1] 2022-12-15 16:31:47 UTC -  Tether USD (USDT)   4496.800000 (4496800000) - from: 0xdfd5293d8  to: 0xf7140bb01 - txid: 0xd3d529d
[2] 2022-12-15 16:31:11 UTC -  Tether USD (USDT)   1496.800000 (1496800000) - from: 0xdfd5293d8  to: 0xcab0e46b1 - txid: 0x0b7986d
[3] 2022-12-15 16:31:11 UTC -  Tether USD (USDT)    122.800000 (122800000) - from: 0xdfd5293d8  to: 0xcc38c0e6f - txid: 0x8894af7
[4] 2022-12-15 16:30:35 UTC -  Tether USD (USDT)  22953.971400 (22953971400) - from: 0xdfd5293d8  to: 0xccb95ec69 - txid: 0x0bb6b75
[5] 2022-12-15 16:30:11 UTC -  Tether USD (USDT)    254.743920 (254743920) - from: 0xdfd5293d8  to: 0x68f2a6311 - txid: 0xf691bed
[6] 2022-12-15 16:29:35 UTC -  Tether USD (USDT)    548.950317 (548950317) - from: 0xdfd5293d8  to: 0xaa00cd50e - txid: 0x847854b
[7] 2022-12-15 16:29:11 UTC -  Tether USD (USDT)  33667.697868 (33667697868) - from: 0xdfd5293d8  to: 0xcfb27a23f - txid: 0x7a2390d
[8] 2022-12-15 16:28:59 UTC -  Tether USD (USDT)  48126.270731 (48126270731) - from: 0xdfd5293d8  to: 0x09857b83a - txid: 0x0653035
[9] 2022-12-15 16:28:35 UTC -  Tether USD (USDT)  15996.800000 (15996800000) - from: 0xdfd5293d8  to: 0xd8d6ffe34 - txid: 0xb02d04b
```


### Get the Latest Moonbird Non-Fungible Token (NFT) Transfers

see <https://docs.etherscan.io/recipes/get-the-latest-moonbird-nft-transfers>

``` ruby
require 'etherscan-lite'

MOONBIRDS_ADDRESS = '0x23581767a106ae21c074b2276D25e5C3e136a68b'

data = Etherscan.tokennfttx( contractaddress: MOONBIRDS_ADDRESS )
pp data
```

resulting in:

``` json
[{"blockNumber": "16191303",
  "timeStamp": "1671121895",
  "hash": "0xf049e3247e19e2eca1971f6daa38e7310bf2705b7da6347b9801122eef57f30e",
  "nonce": "16348",
  "blockHash": "0x2ec6abfc229cb61b7a851d9e078e93681634cf0b2b3390a54f6fa21e8d10cd04",
  "from": "0x8ae57a027c63fca8070d1bf38622321de8004c67",
  "contractAddress": "0x23581767a106ae21c074b2276d25e5c3e136a68b",
  "to": "0xdc3276739390e3fdf7929056593d2ce316ebcfa8",
  "tokenID": "2934",
  "tokenName": "Moonbirds",
  "tokenSymbol": "MOONBIRD",
  "tokenDecimal": "0",
  "transactionIndex": "150",
  "gas": "168819",
  "gasPrice": "30350829601",
  "gasUsed": "64019",
  "cumulativeGasUsed": "16664047",
  "input": "deprecated",
  "confirmations": "25"},
 {"blockNumber": "16191297",
  "timeStamp": "1671121823",
  "hash": "0xb341b32b2c8904733c05648f67c09c99602a22b454f6f99b68746eb204c8f235",
  "nonce": "4310",
  "blockHash": "0x8774a12b660e59586ae94af1670362d2c73d09c94230f236859548ae0768f387",
  "from": "0x8bc110db7029197c3621bea8092ab1996d5dd7be",
  "contractAddress": "0x23581767a106ae21c074b2276d25e5c3e136a68b",
  "to": "0x6ce2eb1c3006850ebbb97499f1a25b8ce6c01a44",
  "tokenID": "9836",
  "tokenName": "Moonbirds",
  "tokenSymbol": "MOONBIRD",
  "tokenDecimal": "0",
  "transactionIndex": "15",
  "gas": "3576346",
  "gasPrice": "35958543341",
  "gasUsed": "2751035",
  "cumulativeGasUsed": "3999647",
  "input": "deprecated",
  "confirmations": "31"},
  ...
]
```

and let's pretty print the data (records):


``` ruby
data.each_with_index do |h,i|
  timestamp =   Time.at( h['timeStamp'].to_i ).utc

  print "  [#{i}] #{timestamp} -  "
  print "#{h['tokenName']} #{h['tokenID']} - "
  print "from: #{h['from'][0..10]}  "
  print "to: #{h['to'][0..10]} - "
  print "txid: #{h['hash'][0..8]}"
  print "\n"
end
```

resulting in:

```
[0] 2022-12-15 16:31:35 UTC -  Moonbirds 2934 - from: 0x8ae57a027  to: 0xdc3276739 - txid: 0xf049e32
[1] 2022-12-15 16:30:23 UTC -  Moonbirds 9836 - from: 0x8bc110db7  to: 0x6ce2eb1c3 - txid: 0xb341b32
[2] 2022-12-15 16:30:23 UTC -  Moonbirds 9378 - from: 0x8bc110db7  to: 0x6ce2eb1c3 - txid: 0xb341b32
[3] 2022-12-15 16:30:23 UTC -  Moonbirds 9059 - from: 0x8bc110db7  to: 0x6ce2eb1c3 - txid: 0xb341b32
[4] 2022-12-15 16:30:23 UTC -  Moonbirds 8199 - from: 0x8bc110db7  to: 0x6ce2eb1c3 - txid: 0xb341b32
[5] 2022-12-15 16:30:23 UTC -  Moonbirds 7800 - from: 0x8bc110db7  to: 0x6ce2eb1c3 - txid: 0xb341b32
[6] 2022-12-15 16:30:23 UTC -  Moonbirds 5952 - from: 0x8bc110db7  to: 0x6ce2eb1c3 - txid: 0xb341b32
[7] 2022-12-15 16:30:23 UTC -  Moonbirds 5868 - from: 0x8bc110db7  to: 0x6ce2eb1c3 - txid: 0xb341b32
[8] 2022-12-15 16:30:23 UTC -  Moonbirds 5853 - from: 0x8bc110db7  to: 0x6ce2eb1c3 - txid: 0xb341b32
[9] 2022-12-15 16:30:23 UTC -  Moonbirds 501 - from: 0x8bc110db7  to: 0x6ce2eb1c3 - txid: 0xb341b32
```



### List ETH deposits to Arbitrum Bridge

see <https://docs.etherscan.io/recipes/list-eth-deposits-to-arbitrum-bridge>


``` ruby
require 'etherscan-lite'

ARBITRUM_DELAYED_INBOX = '0x4dbd4fc535ac27206064b68ffcf827b0a60bab3f'

data = Etherscan.txlist( address: ARBITRUM_DELAYED_INBOX )
pp data
```

resulting in:


``` json
[{"blockNumber": "16191330",
  "timeStamp": "1671122219",
  "hash": "0xea692b153ec048322dd6dc0a42fba45a0f06b2bd0e6888c7e42edbc629689f00",
  "nonce": "998",
  "blockHash": "0x3c3a23b78fd1522f9f9ed5a1fc45d5a7d1d71327961c77d164c0eeb1e72b4322",
  "transactionIndex": "244",
  "from": "0xae4705dc0816ee6d8a13f1c72780ec5021915fed",
  "to": "0x4dbd4fc535ac27206064b68ffcf827b0a60bab3f",
  "value": "420690000000000000",
  "gas": "92219",
  "gasPrice": "26218969764",
  "isError": "0",
  "txreceipt_status": "1",
  "input": "0x439370b1",
  "contractAddress": "",
  "cumulativeGasUsed": "18496407",
  "gasUsed": "91261",
  "confirmations": "16",
  "methodId": "0x439370b1",
  "functionName": "depositEth()"},
 {"blockNumber": "16191327",
  "timeStamp": "1671122183",
  "hash": "0x8a82fc0e7ac1fb588f1ee248810d518bc03dfb4e938160c6502f949fcc16054c",
  "nonce": "2",
  "blockHash": "0xb533b2cd157369414839c58b74319bf32400dd6521b5d945eb7ac405d0600203",
  "transactionIndex": "78",
  "from": "0x338b8d83e644689a0ea90f04e0efa144fccfb3c7",
  "to": "0x4dbd4fc535ac27206064b68ffcf827b0a60bab3f",
  "value": "19000000000000000",
  "gas": "92219",
  "gasPrice": "29492008048",
  "isError": "0",
  "txreceipt_status": "1",
  "input": "0x439370b1",
  "contractAddress": "",
  "cumulativeGasUsed": "7020870",
  "gasUsed": "91261",
  "confirmations": "19",
  "methodId": "0x439370b1",
  "functionName": "depositEth()"},
  ...
]
```

and let's pretty print the data (records):


``` ruby
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
```

resulting in:

```
[0] 2022-12-15 16:36:59 UTC -  depositEth()   0.420690000000000000 (420690000000000000) - from: 0xae4705dc0  to: 0x4dbd4fc53 - txid: 0xea692b1
[1] 2022-12-15 16:36:23 UTC -  depositEth()   0.019000000000000000 (19000000000000000) - from: 0x338b8d83e  to: 0x4dbd4fc53 - txid: 0x8a82fc0
[2] 2022-12-15 16:35:23 UTC -  depositEth()   0.040000000000000000 (40000000000000000) - from: 0x63e1c7edc  to: 0x4dbd4fc53 - txid: 0x46bc422
[3] 2022-12-15 16:34:23 UTC -  depositEth()   0.003330000000000000 (3330000000000000) - from: 0xe29abe7f8  to: 0x4dbd4fc53 - txid: 0x2fbd49e
[4] 2022-12-15 16:34:23 UTC -  depositEth()   0.022398548608559353 (22398548608559353) - from: 0x3dbcf6a3d  to: 0x4dbd4fc53 - txid: 0xc311e3f
[5] 2022-12-15 16:32:23 UTC -  depositEth()   0.195713000000000000 (195713000000000000) - from: 0xc7099c3ed  to: 0x4dbd4fc53 - txid: 0x4a2f2e4
[6] 2022-12-15 16:31:23 UTC -  depositEth()   0.100000000000000000 (100000000000000000) - from: 0x78cea29ac  to: 0x4dbd4fc53 - txid: 0xedc3793
[7] 2022-12-15 16:28:35 UTC -  depositEth()   2.406000000000000000 (2406000000000000000) - from: 0xa59192967  to: 0x4dbd4fc53 - txid: 0xde20917
[8] 2022-12-15 16:28:23 UTC -  depositEth()   0.030000000000000000 (30000000000000000) - from: 0x03a64c941  to: 0x4dbd4fc53 - txid: 0xc813c01
[9] 2022-12-15 16:27:35 UTC -  depositEth()   0.004000000000000000 (4000000000000000) - from: 0x614d071bf  to: 0x4dbd4fc53 - txid: 0xb24df57
```

and so on.






## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.


