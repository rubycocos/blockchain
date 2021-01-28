###
#  to run use
#     ruby -I ./lib sandbox/test_ethereum.rb


require 'crypto-lite'


##
# see https://github.com/ethereumbook/ethereumbook/blob/develop/04keys-addresses.asciidoc


puts 'keccak256:'
pp keccak256( '' )
#=> "c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470"
puts 'sha3_256:'
pp sha3_256( '' )
#=> "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a"
puts

### expected hashes from the ethereum book
# Keccak256("") =
#  c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470
#
# SHA3("") =
#  a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a



pp key = 0xf8f8a2f43c8376ccb0871305060d7b27b0554d2cc72bccf41b2705608452f315

group = EC::Secp256k1
# point = group.generator.multiply_by_scalar( key.to_i(16) )
# puts 'public key: '
#puts '  x: %x' % point.x
#puts '  y: %x' % point.y
#
# pp pub = "%x%x" % [point.x,point.y]

puts "---"
private_key = EC::PrivateKey.new( 0xf8f8a2f43c8376ccb0871305060d7b27b0554d2cc72bccf41b2705608452f315 )
pp private_key.to_i
#=> 112612889188223089164322846106333497020645518262799935528047458345719983960853
pp private_key.to_s
#=> "f8f8a2f43c8376ccb0871305060d7b27b0554d2cc72bccf41b2705608452f315"
puts "---"


public_key =  private_key.public_key   ## the "magic" one-way K=k*G curve multiplication (K=public key,k=private key, G=generator point)
point = public_key.point

pp point.x
#=> 49790390825249384486033144355916864607616083520101638681403973749255924539515
pp point.y
#=> 59574132161899900045862086493921015780032175291755807399284007721050341297360
pp point.x.to_s(16)
#=> "6e145ccef1033dea239875dd00dfb4fee6e3348b84985c92f103444683bae07b"
pp point.y.to_s(16)
#=> "83b5c38e5e2b0c8529d7fa3f64d46daa1ece2d9ac14cab9477d042c84c32ccd0"

pp "%64x%64x" % [point.x, point.y]
#=>

# or
pp ("%64x" % point.x) + ("%64x" % point.y)
#=>


puts "---"




pp key ="f8f8a2f43c8376ccb0871305060d7b27b0554d2cc72bccf41b2705608452f315"
pp key.to_i(16)

private_key = EC::PrivateKey.new( key.to_i(16) )
pp private_key.to_i
pp private_key.to_s

public_key = private_key.public_key
point = public_key.point
puts 'public key: '
puts '  x: %x' % point.x
puts '  y: %x' % point.y
#=>  x: 6e145ccef1033dea239875dd00dfb4fee6e3348b84985c92f103444683bae07b
#=>  y: 83b5c38e5e2b0c8529d7fa3f64d46daa1ece2d9ac14cab9477d042c84c32ccd0

# exptected from the ethereum book
# x = 6e145ccef1033dea239875dd00dfb4fee6e3348b84985c92f103444683bae07b
# y = 83b5c38e5e2b0c8529d7fa3f64d46daa1ece2d9ac14cab9477d042c84c32ccd0

pp pub = "%64x%64x" % [point.x,point.y]
#=> "6e145ccef1033dea239875dd00dfb4fee6e3348b84985c92f103444683bae07b83b5c38e5e2b0c8529d7fa3f64d46daa1ece2d9ac14cab9477d042c84c32ccd0"


pp hash = keccak256(pub)
#=> "2a5bc342ed616b5ba5732269001d3f1ef827552ae1114027bd3ecf1f086ba0f9"

## expected result from ethereum book:
##  => 2a5bc342ed616b5ba5732269001d3f1ef827552ae1114027bd3ecf1f086ba0f9


puts "addr:"
pp hash[24,40]  ## last 20 bytes of 32 (skip first 12 bytes (12x2=24 hexchars))
pp hash[-40..-1]  ## last 20 bytes
pp hash[-40,40]  ## last 20 bytes
#=> "001d3f1ef827552ae1114027bd3ecf1f086ba0f9"

## expected result from ethereum book:
##  => 001d3f1ef827552ae1114027bd3ecf1f086ba0f9

