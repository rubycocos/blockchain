###
#  to run use
#     ruby -I ./lib sandbox/test_dodge.rb

## chain params (for address generation, private key imports/exports, etc.):
##
##
##       |  BIP 44    |      mainnet             |     mainnet     |     mainnet     |
## Coin  | coin_type  |    version_WIF            |  version_p2pkh  |  version_p2sh   |
## ------|------------|-----------|---------------|-----------------|-----------------|
## DOGE  |      3     |        158 (or 0x9e)      |  30/('D')       |  22/('9' or 'A') |



require 'crypto-lite'



private_key = EC::PrivateKey.new( 50303382071965675924643368363408442017264130870580001935435312336103014915707 )

pp public_key =  private_key.public_key   ## the "magic" one-way K=k*G curve multiplication (K=public key,k=private key, G=generator point)
pp point = public_key.point

pp point.x
#=> 17761672841523182714332746445483761684317159074072585653954580096478387916431
pp point.y
#=> 81286693084077906561204577435230199871025343781583806206090259868058973358862

pp point.to_s( :compressed )
#=> "022744c02580b4905349bc481a60c308c2d98d823d44888835047f6bc5c38c4e8f"
pp point.to_s( :uncompressed )
#=> "042744c02580b4905349bc481a60c308c2d98d823d44888835047f6bc5c38c4e8fb3b6a34b90a571f6c2a1113dd5ff4576f61bbf3e970a6e148fa02bf9eb7bcb0e"



pk = "022744c02580b4905349bc481a60c308c2d98d823d44888835047f6bc5c38c4e8f"

pp step1 = hash160( pk )
#=> "a1f37969bcb547cd9c3a28fa07c2269ef813340a"

# 2. Add version byte in front of RIPEMD-160 hash (0x1e for Dodge Main Network)
pp step2 = "1e" + step1
#=> "1ea1f37969bcb547cd9c3a28fa07c2269ef813340a"

# 3. Encode with BASE58CHECK
#    a) Perform SHA-256 hash on the extended RIPEMD-160 result
#    b) Perform SHA-256 hash on the result of the previous SHA-256 hash
#    c) Take the first 4 bytes of the second SHA-256 hash. This is the address checksum
#    d) Add the 4 checksum bytes at the end of
#       extended RIPEMD-160 hash from step 2.
#       This is the 25-byte binary Dodge Address.
#    e) Convert the result from a byte string into a base58 string
#       using Base58 encoding.
#       This is the most commonly used Dodge Address format.
pp addr  = base58check( step2 )
#=> "DKuR12onkdp5GxC5c8DgXhGe4Z2AqCK3Xh"



