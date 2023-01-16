#  Ready-To-Use (Blockchain) Contract Services / Function Calls For Ethereum & Co.


ethlite-contracts  - ready-to-use (blockchain) contract services / function calls for ethereum & co


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/ethlite-contracts](https://rubygems.org/gems/ethlite-contracts)
* rdoc  :: [rubydoc.info/gems/ethlite-contracts](http://rubydoc.info/gems/ethlite-contracts)



## Usage by Example


### Contract №1 - Nouns, NounsSeeder, NounsDescriptor, NounsDescriptorV2

Let's try the `Nouns` contract
with  the token id 1, that is, noun no. 1:

``` ruby
require 'ethlite/contracts'


contract = Nouns.new

contract.totalSupply    # as of Jan/16, 2023
#=> 580

token_ids = [1,2,3]
token_ids.each do |token_id|
  pp seeds = contract.seeds( token_id )
  #=> [1, 20, 95, 88, 14]
  #  for background, body, accessory, head, glasses

  str = contract.tokenURI( token_id )
  if str.start_with?( 'data:application/json;base64,' )
    str = str.sub( 'data:application/json;base64,', '' )
    ## get metadata (base64-encoded)
    data = JSON.parse( Base64.decode64( str ) )
    pp data
#=>  {"name"=>"Noun 1",
#      "description"=>"Noun 1 is a member of the Nouns DAO",
#      "image"=> "data:image/svg+xml;base64..."
#     }
    str_image = data['image']
    str_image = str_image.sub( 'data:image/svg+xml;base64,', '' )
    image = Base64.decode64( str_image )
    write_text( "./tmp/noun#{token_id}.svg", image )
  else
    puts "!! ERROR - expected json base64-encoded; got:"
    pp str
    exit 1
  end
end


contract.seeder
#=> "cc8a0fb5ab3c7132c1b2a0109142fb112c4ce515"

contract.descriptor
#=> "6229c811d04501523c6058bfaac29c91bb586268"
```

Note:  See [`nouns/noun1.svg`](nouns/noun1.svg),
[`nouns/noun2.svg`](nouns/noun2.svg),
etc. for the saved copies of the ("on-chain") image data.


Let's try the `NounsSeeder` contract
that returns the pseudo-random seeds for a noun.
Note - the formula uses the blockhash - 1, and, thus,
is only deterministic, that is, returns the same seeds - if called within the same block:


``` ruby
contract = NounsSeeder.new

# using the address of NounsDescriptor
contract.generateSeed( 1, '0x0cfdb3ba1694c2bb2cfacb0339ad7b1ae5932b63' )
#=> [1, 15, 54, 48, 16]
#      for background, body, accessory, head, glasses


# using the address of NounsDescriptorV2
contract.generateSeed( 579, '0x6229c811d04501523c6058bfaac29c91bb586268' )
#=> [0, 25, 83, 99, 9]
contract.generateSeed( 579, '0x6229c811d04501523c6058bfaac29c91bb586268' )
#=> [0, 25, 83, 99, 9]
```

Let's try the `NounsDescriptor` and
`NounsDescriptorV2` contracts and get the max available
artwork counts:

``` ruby
contract = NounsDescriptor.new

contract.backgroundCount    #=> 2
contract.bodyCount          #=> 30
contract.accessoryCount     #=> 137
contract.headCount          #=> 234
contract.glassesCount       #=> 21

contract = NounsDescriptorV2.new

contract.backgroundCount   #=> 2
contract.bodyCount         #=> 30
contract.accessoryCount    #=> 140
contract.headCount         #=> 242
contract.glassesCount      #=> 23
```

And lets generate some more nouns via seeds
using the `NounsDescriptorV2` contract:

``` ruby
seeds = [1, 20, 95, 88, 14]
#    for background, body, accessory, head, glasses
str = contract.generateSVGImage( seeds )
svg = Base64.decode64( str )
write_text( "nouns/noun_#{seeds.join('-')}.svg", svg )
```




### Contract №2 - SynthPunks

Let's try the `SynthPunks` contract that lets you generate
punks for every ethereum address. Note - the punk token id is
the ethereum address converted into a (big) integer number:


``` ruby
contract  = SynthPunks.new

## let's add "pure ruby" helper
##  convert hex string (that is, address) to (big) integer
def getTokenID( address ) address.to_i( 16 ); end

getTokenID( '0x71c7656ec7ab88b098defb751b7401b5f6d8976f' )
#=> 649562641434947955654834859981556155081347864431
getTokenID( '0x0000000000000000000000000000000000000000' )
#=> 0



token_ids = [
  30311890011735557186986086868537068337617285922,
  699372119169819039191610289391678040975564001026,
  getTokenID( '0x71c7656ec7ab88b098defb751b7401b5f6d8976f' ),
]

token_ids.each do |token_id|
  contract.getAttributes( token_id )
end
#=> [6,20,109,114,14]
#=> [0,12,65,124,41]
#=> [7,27,15]

[
 [6,20,109,114,14],
 [0,12,65,124,41],
 [7,27,15],
].each do |attributes|
  svg = contract.generatePunkSVG( attributes )
  write_text( "synthpunks/punk_#{attributes.join('-')}.svg", svg )
end


token_ids.each do |token_id|
  str = contract.tokenURI( token_id )
  if str.start_with?( 'data:application/json;base64,' )
     str = str.sub( 'data:application/json;base64,', '' )
     data = JSON.parse( Base64.decode64( str ) )
     ## extract image
     ##  "image"=> "data:image/svg+xml;base64
     str_image = data.delete( 'image' )
     str_image = str_image.sub( 'data:image/svg+xml;base64,', '' )
     image = Base64.decode64( str_image )

     write_json( "synthpunks/punk#{token_id}.json", data )
     write_text( "synthpunks/punk#{token_id}.svg", image )
  else
    puts "!! ERROR - expected json base64-encoded; got:"
    pp str
    exit 1
  end
end
```




### Contract №3 - PunksMeta  (aka CryptoPunksTokenUri)  by 0xTycoon

_The missing tokenURI() for the Punks_


Let's try the `PunksMeta` contract
with  the token id 0, that is, punk no. 0:

``` ruby
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
and [`punksmeta/punk0.svg`](punksmeta/punk0.svg) for the saved copies of the "on-chain" data.





## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.


