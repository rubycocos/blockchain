###
#  to run use
#     ruby -I ./lib sandbox/test_nouns.rb



require 'ethlite/contracts'


####################
# try  NounsDescriptor

contract = NounsDescriptor.new

pp contract.arePartsLocked
#=> false

pp contract.backgroundCount
#=> 2
pp contract.bodyCount
#=> 30
pp contract.accessoryCount
#=> 137
pp contract.headCount
#=> 234
pp contract.glassesCount
#=> 21

## struct INounsSeeder.Seed
## struct Seed {
##  uint48 background;
##  uint48 body;
##  uint48 accessory;
##  uint48 head;
##  uint48 glasses;
## }


seeds = [
  [0,0,0,0,0],
  [1,1,1,1,1],
  [0,1,2,3,4],
]
seeds.each do |seed|
  str = contract.generateSVGImage( seed )
  svg = Base64.decode64( str )
  pp svg

  write_text( "./tmp/noun_#{seed.join('-')}.svg", svg )
end



####################
# try  NounsDescriptorV2

contract = NounsDescriptorV2.new

pp contract.arePartsLocked
#=> false

pp contract.backgroundCount
#=> 2
pp contract.bodyCount
#=> 30
pp contract.accessoryCount
#=> 140
pp contract.headCount
#=> 242
pp contract.glassesCount
#=> 23

seeds = [
  [0,0,0,0,0],
  [1,1,1,1,1],
  [0,1,2,3,4],
]
seeds.each do |seed|
  str = contract.generateSVGImage( seed )
  svg = Base64.decode64( str )
  pp svg

  write_text( "./tmp/nounv2_#{seed.join('-')}.svg", svg )
end



####################
# try  NounsSeeder

contract = NounsSeeder.new

pp contract.generateSeed( 1, '0x0cfdb3ba1694c2bb2cfacb0339ad7b1ae5932b63' )
#=> [1, 15, 54, 48, 16]

## note: only within same blocktime returns same result
##        source of entropy is blockhash - 1 !!!
pp contract.generateSeed( 579, '0x6229c811d04501523c6058bfaac29c91bb586268' )
#=> [0, 25, 83, 99, 9]
pp contract.generateSeed( 579, '0x6229c811d04501523c6058bfaac29c91bb586268' )
#=> [0, 25, 83, 99, 9]



#####################
# try Nouns

contract = Nouns.new

# pp contract.descriptor
#=> "6229c811d04501523c6058bfaac29c91bb586268"

# pp contract.seeder
#=> "cc8a0fb5ab3c7132c1b2a0109142fb112c4ce515"

pp contract.totalSupply
#=> 580


# (uint48 background,
#  uint48 body,
#  uint48 accessory,
#  uint48 head,
#  uint48 glasses)
# pp seed = contract.seeds( 1 )
#=> [1, 20, 95, 88, 14]

# pp seed = contract.seeds( 2 )
#=> [1, 3, 3, 157, 20]


token_ids = [1,2,3]
token_ids.each do |token_id|
  pp seed = contract.seeds( token_id )

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
    str_image = data.delete( 'image' )
    str_image = str_image.sub( 'data:image/svg+xml;base64,', '' )
    image = Base64.decode64( str_image )
    write_text( "./tmp/noun#{token_id}.svg", image )
  else
    puts "!! ERROR - expected json base64-encoded; got:"
    pp str
    exit 1
  end
end


puts "bye"
