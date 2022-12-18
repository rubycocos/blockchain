###
#  use etherscan api to lint / check-up on contract addresses
#     (and get creation timestamp etc.)
#
#  to run use
#     ruby -I ./lib sandbox/timeline.rb


$LOAD_PATH.unshift( "../etherscan-lite/lib" )

require 'ethname'
require 'etherscan-lite'

puts "  #{Ethname.directory.size} (contract) address record(s)"

##  step 1:
## collect more metadata about (contract) address

meta = []


Ethname.directory.records.each_with_index do |rec,i|
  puts "==> [#{i+1}] #{rec.names.join('|')} @ #{rec.addr} supports #{rec.interfaces.join('|')}..."

  data = Etherscan.getcontractdetails( contractaddress: rec.addr )
  pp data
  # {"contractAddress"=>"0x16f5a35647d6f03d5d3da7b35409d65ba03af3b2",
  #   "contractCreator"=>"0xc352b534e8b987e036a93539fd6897f53488e56a",
  #   "txHash"=>"0xc82aa34310c310463eb9fe7835471f7317ac4b5008034a78c93b2a8a237be228",
  #  ...}

   ## note: timestamp is a (encoded) hex string e.g. "0x598a9136"
   timestamp = data['timestamp'].to_i(16)
   blocknumber =  data['blockNumber'].to_i(16)   ## convert to decimal


   meta << [ rec,
             { 'address' => data['contractAddress'],
               'creator' => data['contractCreator'],
               'txid' => data['txHash'],
               'blocknumber' => blocknumber,
               'timestamp' => timestamp
             }
           ]

  ## print last added entry
  puts meta[-1]
end

## sort by blocknumber  (reverse chronological)
meta = meta.sort { |l,r| l[1]['blocknumber'] <=> r[1]['blocknumber'] }

puts
pp meta



## create report / page

buf = "# Contracts - Timeline\n\n"

meta.each do |rec,data|

  txid        = data['txid']
  creator     = data['creator']
  blocknumber = data['blocknumber']
  timestamp   = data['timestamp']
  date = Time.at( timestamp).utc


  buf << "###  #{rec.names.join( ' | ')} - #{date.strftime('%b %-d, %Y')}\n\n"

  buf << "_#{rec.interfaces.join(' | ' )}_\n\n"    unless rec.interfaces.empty?

  buf << "contract @ [**#{rec.addr}**](https://etherscan.io/address/#{rec.addr})\n\n"

  buf << "created by [#{creator}](https://etherscan.io/address/#{creator}))"
  buf << " at block no. #{blocknumber} (#{date})"
  buf << " - txid [#{txid}](https://etherscan.io/tx/#{txid})"
  buf << "\n\n"
end



write_text( './CONTRACTS.md', buf )




puts "bye"

__END__


[["0x6ba6f2207e343923ba692e5cae646fb0f566db8d",
  "0xc352b534e8b987e036a93539fd6897f53488e56a",
  "0x9fef127966d59d440c70f28c8e6f1eac3af0d91f94384e207deb3c98ff9c3088",
  "3842489",
  "1496967770",
  "2017-06-09 00:22:50 UTC",
  "punks v1|crypto punks v1"],
 ["0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb",
  "0xc352b534e8b987e036a93539fd6897f53488e56a",
  "0x0885b9e5184f497595e1ae2652d63dbdb2785de2e498af837d672f5765f28430",
  "3914495",
  "1498160400",
  "2017-06-22 19:40:00 UTC",
  "punks v2|crypto punks v2|crypto punks market"],
 ["0x60cd862c9c687a9de49aecdc3a99b74a4fc54ab6",
  "0xa97f8ffc8f8e354475880448334e4e99a0e7212f",
  "0x79d48c41b99f0ac8f735dbf4d048165542576862df2b05a80be9a4dbe233a623",
  "4134866",
  "1502253366",
  "2017-08-09 04:36:06 UTC",
  "mooncats|mooncatrescue"],
 ["0x16f5a35647d6f03d5d3da7b35409d65ba03af3b2",
  "0xc352b534e8b987e036a93539fd6897f53488e56a",
  "0xc82aa34310c310463eb9fe7835471f7317ac4b5008034a78c93b2a8a237be228",
  "13045935",
  "1629245424",
  "2021-08-18 00:10:24 UTC",
  "punks data|crypto punks data"],
 ["0xf4a4644e818c2843ba0aabea93af6c80b5984114",
  "0xe5ee2b9d5320f2d1492e16567f36b578372b3d9f",
  "0xf0e2405d1ed790d4e97bd0dafd22a649fcb485d91cef94f30f931ddb26fd1ea2",
  "12105923",
  "1616646403",
  "2021-03-25 04:26:43 UTC",
  "punks v1 wrapped i|classic punks"],
 ["0xa82f3a61f002f83eba7d184c50bb2a8b359ca1ce",
  "0xdd01e9be0f8ac1be72f57a29e2e960777ef2d152",
  "0x48db643b9ee37de131e23456ecf35c3a270cba12b4e952f02fe7e5af0bb2a0cc",
  "12630376",
  "1623644333",
  "2021-06-14 04:18:53 UTC",
  "phunks v1|philips"],
 ["0xf07468ead8cf26c752c676e43c814fee9c8cf402",
  "0xdd01e9be0f8ac1be72f57a29e2e960777ef2d152",
  "0x994a30d91c09ecf14aef8fe42140742584762d3522a2016bd386361e6d76d4e2",
  "12674389",
  "1624234028",
  "2021-06-21 00:07:08 UTC",
  "phunks v2|phunks"],
 ["0x031920cc2d9f5c10b444fd44009cd64f829e7be2",
  "0x3549d95f144c0cc9eb5fc29fc8b6881a84d51536",
  "0x7e7c76df42ac448443e5b6dfadb35d64ebd44d03abf8cc04536ef43dca54f27a",
  "12975638",
  "1628308877",
  "2021-08-07 04:01:17 UTC",
  "zunks"],
 ["0x0d0167a823c6619d430b1a96ad85b888bcf97c37",
  "0x930b9cc24c46c341803e5fefb3590bdb4ff576a6",
  "0xc9305055eccbe710c0b2f54dc6ff7560fc2e78bd2883ffc0acb0eff705edd86e",
  "13026517",
  "1628986400",
  "2021-08-15 00:13:20 UTC",
  "xpunks|expansion punks"],
 ["0x71eb5c179ceb640160853144cbb8df5bd24ab5cc",
  "0xe51c910738a91ed6c966f6d0d6c25289d4292613",
  "0xb89a15ae987bacfb62baed9bcc2065644617d25fcb8498b1ba8f4fb80fdd8c8c",
  "13906069",
  "1640859279",
  "2021-12-30 10:14:39 UTC",
  "xphunks|expansion phunks"],
 ["0x282bdd42f4eb70e7a9d9f40c8fea0825b7f68c5d",
  "0xf40fd88ac59a206d009a07f8c09828a01e2acc0d",
  "0xf7132661519e08b5804c22f0d0846146c645229dd803f85d81a417bce44992da",
  "14022431",
  "1642414507",
  "2022-01-17 10:15:07 UTC",
  "punks v1 wrapped ii"],
 ["0xd33c078c2486b7be0f7b4dda9b14f35163b949e0",
  "0x07558ea3218e62c00090003f420bd8272456ecc8",
  "0x7ee2156cea4a19887bc93ecfd2ee27a6b2d8c412a888a4d25b138b86082a1712",
  "14127834",
  "1643821079",
  "2022-02-02 16:57:59 UTC",
  "punks v3"],
 ["0xd12882c8b5d1bccca57c994c6af7d96355590dbd",
  "0xc874f918f29addeb8d0a377a625fcaa91007ca66",
  "0xd02314f9638dd3db61c85cfaf4d11dd3abf85952619e7a87aea43c72c6adb3b9",
  "14138557",
  "1643965066",
  "2022-02-04 08:57:46 UTC",
  "punks v4"],
 ["0xa19f0378a6f3f3361d8e962f3589ec28f4f8f159",
  "0xd59d10f5a49d6c8ec097e007a1782087cfb4b988",
  "0x66740bf047483e9b489c2837146260102b2b9537236dfd2d72caee2f45539a05",
  "14132029",
  "1643878192",
  "2022-02-03 08:49:52 UTC",
  "phunks v3"],
 ["0xaf9ce4b327a3b690abea6f78eccbfefffbea9fdf",
  "0x3ce6543978f37315e047236139817c1f446300e5",
  "0xfd08b691d12ff2cf05e7edccd2a311e124bffdfeb528d666c98221c93dd3d648",
  "14199397",
  "1644776863",
  "2022-02-13 18:27:43 UTC",
  "synthetic punks|synth punks"],
 ["0x58e90596c2065befd3060767736c829c18f3474c",
  "0xc43473fa66237e9af3b2d886ee1205b81b14b2c8",
  "0x92d3a69c4ac96ddd432f1c13e5dbb8bf3d7782489e7ee3538e78a25f2480c34f",
  "16150497",
  "1670629379",
  "2022-12-09 23:42:59 UTC",
  "punk blocks"],
 ["0x23581767a106ae21c074b2276d25e5c3e136a68b",
  "0x6c8984baf566db08675310b122bf0be9ea269eca",
  "0xd4547dc336dd4a0655f11267537964d7641f115ef3d5440d71514e3efba9d210",
  "14591056",
  "1650040710",
  "2022-04-15 16:38:30 UTC",
  "moonbirds"]]

