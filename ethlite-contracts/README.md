#  Ready-To-Use (Blockchain) Contract Services / Function Calls For Ethereum & Co.


ethlite-contracts  - ready-to-use (blockchain) contract services / function calls for ethereum & co


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/ethlite-contracts](https://rubygems.org/gems/ethlite-contracts)
* rdoc  :: [rubydoc.info/gems/ethlite-contracts](http://rubydoc.info/gems/ethlite-contracts)



## Usage by Example

### Contract №1 - PunksMeta  (aka CryptoPunksTokenUri)  by 0xTycoon

_The missing tokenURI() for the Punks_


Let's try the `PunksMeta` contract
with  the token id 0, that is, punk no. 0:

``` ruby
require 'ethlite/contracts'

contract = PunksMeta.new


#  function parseAttributes(uint256 _tokenId) returns (string[8])
#
#  parseAttributes returns an array of punk attributes. 8 rows in total
#      The first row is the Type, and next seven rows are the attributes.
#      The values are fetched form the CryptoPunksData contract and then the
#      string is parsed.
#    @param _tokenId the punk id
ary = contract.parseAttributes( 0 )
#=> ["Female 2", "Earring", "Blonde Bob", "Green Eye Shadow", "", "", "", ""]


#  function getAttributes(uint256 _tokenId) returns (string)
#
#  getAttributes calls parseAttributes and returns the result as JSON
#    @param _tokenId the punk id
str = contract.getAttributes( 0 )
data = JSON.parse( str )
#=> [{"trait_type"=>"Type", "value"=>"Female 2"},
#    {"trait_type"=>"Accessory", "value"=>"Earring"},
#    {"trait_type"=>"Accessory", "value"=>"Blonde Bob"},
#    {"trait_type"=>"Accessory", "value"=>"Green Eye Shadow"}]


#  function tokenURI(uint256 _tokenId)  returns (string)
#
#  tokenURI gets the metadata about a punk and returns as a JSON
#      formatted string, according to the ERC721 schema and market
#      recommendations. It also embeds the SVG data.
#      The attributes and SVG data are fetched form the CryptoPunksData
#      contract, which stores all the CryptoPunks metadata on-chain.
#    @param _tokenId the punk id
str = contract.tokenURI( 0 )
if str.start_with?( 'data:application/json;base64,' )
  str = str.sub( 'data:application/json;base64,', '' )
  ## get metadata (base64-encoded)
  data = JSON.parse( Base64.decode64( str ) )
#=> {"description"=> "CryptoPunks launched as a fixed set of 10,000 items in mid-2017...",
#    "external_url"=>"https://cryptopunks.app/cryptopunks/details/0",
#    "image"=> "data:image/svg+xml;base64,...",
#    "name"=>"CryptoPunk #0",
#    "attributes"=>
#      [{"trait_type"=>"Type", "value"=>"Female 2"},
#       {"trait_type"=>"Accessory", "value"=>"Earring"},
#       {"trait_type"=>"Accessory", "value"=>"Blonde Bob"},
#       {"trait_type"=>"Accessory", "value"=>"Green Eye Shadow"}]}

      ## get image (base64-encoded)
      str_image = data.delete( 'image' )
      str_image = str_image.sub( 'data:image/svg+xml;base64,', '' )
      image = Base64.decode64( str_image )
      ## cut-off inline leading data:image/svg+xml;utf8, too
      image = image.sub( 'data:image/svg+xml;utf8,', '' )

      write_json( "punksmeta/punk0.json", data )
      write_text( "punksmeta/punk0.svg", image )
   else
     puts "!! ERROR - expected json base64-encoded; got:"
     pp str
     exit 1
   end
end
```

Note:  See [`punksmeta/punk0.json`](punksmeta/punk0.json)
and [`punksmeta/punk0.svg`](punksmeta/punk0.svg) for the saved copies of the data.





## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.


