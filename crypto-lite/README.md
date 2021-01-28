# crypto-lite - Cryptographic Secure Hash Functions and Public Key Signature Algorithms Made Easy



* home  :: [github.com/rubycoco/blockchain](https://github.com/rubycoco/blockchain)
* bugs  :: [github.com/rubycoco/blockchain/issues](https://github.com/rubycoco/blockchain/issues)
* gem   :: [rubygems.org/gems/crypto-lite](https://rubygems.org/gems/crypto-lite)
* rdoc  :: [rubydoc.info/gems/crypto-lite](http://rubydoc.info/gems/crypto-lite)


## Usage

### Secure Hashing / Hash Functions

**SHA256 - Secure Hash Algorithm (SHA) 256-Bit (32 Bytes)**


``` ruby
require 'crypto'      ## or use require 'crypto-lite'

## try abc
sha256( "abc" )           #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( "abc".b )         #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( "\x61\x62\x63" )  #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( 0x616263 )        #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"

sha256( hex: '616263' )     #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( hex: '0x616263' )   #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( hex: '0X616263' )   #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"

# "auto-magic" hex string to binary string conversion heuristic
sha256( '0x616263' )      #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( '0X616263' )      #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
```


Bonus Back Stage Tip: How does SHA256 work?

Try this [amazing animation of the SHA256 hash function in your very own terminal](https://github.com/in3rsha/sha256-animation) by Greg Walker.

More of a code golfer? See [½ Kilo of SHA256](https://idiosyncratic-ruby.com/51-half-kilo-of-sha256.html) by Jan Lelis - yes, the SHA256 algorithm coded (from scratch) in 500 bytes of ruby.


Onwards with more sha256 examples:

``` ruby
## try a
sha256( "a" )         #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( "\x61" )      #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( 0b01100001 )  #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( 0x61 )        #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"

sha256( hex: '61' )     #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( hex: '0x61' )   #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"

# "auto-magic" hex string to binary string conversion heuristic
sha256( '0x61' )      #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"


## try some more
sha256( "Hello, Cryptos!" )  #=> "33eedea60b0662c66c289ceba71863a864cf84b00e10002ca1069bf58f9362d5"
```


**SHA3-256 - Secure Hashing Algorthim (SHA) 3, 256-Bit (32 Bytes)**

``` ruby
sha3_256( "Hello, Cryptos!" )  #=> "7dddf4bc9b86352b67e8823e5010ddbd2a90a854469e2517992ca7ca89e5bd58"
```

Note:  Yes, SHA256 vs SHA3-256 / SHA-2 vs SHA-3 the hashing functions are
different (although the 256-bit hash size output is the same).
The sha256 hashing function is part of the Secure Hash Algorithm (SHA) 2 family / standards first published in 2001.
The sha3_256 is part of the (newer) Secure Hash Algorithm (SHA) 3 family / standards first published in 2015
(and uses the Keccak cryptographic primitive "under the hood").



**Keccak 256-Bit**

``` ruby
keccak256( "Hello, Cryptos!" )  #=> "2cf14baa817e931f5cc2dcb63c889619d6b7ae0794fc2223ebadf8e672c776f5"
```


#### Aside - Keccak vs SHA3 / Original vs Official

In 2004 the U.S. National Institute of Standards and Technology (NIST)
changed the padding to `SHA3-256(M) = KECCAK [512] (M || 01, 256)`.
This is different from the padding proposed by the Keccak team in
the original Keccak SHA-3 submission version 3 (the final, winning version).
The difference is the additional `'01'` bits appended to the message.

To help avoid confusion the "submitted original version 3" SHA-3 Keccak
hashing is now called "Keccak"
and the finalized NIST SHA-3 standard "SHA3".

Tip: If you don't know what variant of the hash function you have -
original or official? - check your hash:

For keccak 256-bit:

``` ruby
keccak256( '' )   #=> "c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470"
```

For sha3 256-bit:

``` ruby
sha3_256( '' )   #=> "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a"
```



**RMD / RIPE-MD  - RACE¹ Integrity Primitives Evaluation Message Digest 160-Bit**

¹: Research and development in Advanced Communications technologies in Europe


``` ruby
rmd160( "Hello, Cryptos!" )     #=>"4d65f7b740bbade4097e1348e15d2a7d52ac5f53"
# or use the alias / alternate name
ripemd160( "Hello, Cryptos!" )  #=>"4d65f7b740bbade4097e1348e15d2a7d52ac5f53"
```


#### Aside - Hex String `"0x616263"` vs Binary String `"\x61\x62\x63" == "abc"`

Note: All hash functions operate on binary strings ("byte arrays")
and NOT hex strings.

Note: For hex strings the `0x` or `0X` prefix is optional.
Examples of hex strings:

``` ruby
# hex string      binary string ("byte array")
"61"              "\x61" == "a"
"0x61"            "\x61" == "a"

"616263"          "\x61\x62\x63" == "abc"
"0x616263"        "\x61\x62\x63" == "abc"
"0X616263"        "\x61\x62\x63" == "abc"

# or   160-bit hex string (hash)
"93ce48570b55c42c2af816aeaba06cfee1224fae"
"0x93ce48570b55c42c2af816aeaba06cfee1224fae"

# or 256-bit hex string (hash)
"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
"0xba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
```

You can use `[str].pack( 'H*' )`
to convert a hex string into a binary string.
Note: The standard `Array#pack` conversion
will NOT "auto-magically" cut-off the `0x` or `0X` prefix.


If you know you have a hex string use the `hex:` keyword to pass
in the arg(ument)
to the hash function and that will "automagically"
handle the hex-to-bin conversion for you. Example:

``` ruby
sha256( hex: '61' )     #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( hex: '0x61' )   #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"

sha256( hex: '616263' )     #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( hex: '0x616263' )   #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( hex: '0X616263' )   #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
```

What about the built-in "auto-magic" hex-to-bin conversion / heuristic?

Yes, if your passed in string starts with the
the `0x` or `0X` prefix the string gets "auto-magically" converted
to binary. Or if your passed in string is all hexadecimal characters,
that is, `0-9` and `a-f` and has a minimum length of ten characters.
Example:


``` ruby
# "auto-magic" hex string to binary string conversion heuristic

sha256( '0x616263' )      #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( '0X616263' )      #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"

# or without 0x or 0X BUT with minimum heuristic length
hash160( '02b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a8737' )
#=> "93ce48570b55c42c2af816aeaba06cfee1224fae"

hash256( '6fe6b145a3908a4d6616b13c1109717add8672c900' )
#=> "02335f08b8fe4ddad263a50b7a33c5d38ea1cbd8fd2056a1320a3ddece541711"

# and so on
```


#### Hash Function Helpers

**HASH160 -  RMD160(SHA256(X))**

All-in-one "best-of-both-worlds" helper - first hash with sha256 and than hash with rmd160. Why?  Get the higher security of sha256 and the smaller size of rmd160.


``` ruby
hash160( '02b9d1cc0b793b03b9f64d022e9c67d5f32670b03f636abf0b3147b34123d13990' )
#=> "e6b145a3908a4d6616b13c1109717add8672c900"

hash160( '02b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a8737' )
#=> "93ce48570b55c42c2af816aeaba06cfee1224fae"
```


**HASH256 -  SHA256(SHA256(X))**

All-in-one double sha256 hash helper, that is, first hash with sha256 and than hash with sha256 again. Why?  Arguably higher security.

> SHA256(SHA256(X)) was proposed by Ferguson and Schneier in their excellent book "Practical Cryptography"
> (later updated by Ferguson, Schneier, and Kohno and renamed "Cryptography Engineering") as a way to make SHA256 invulnerable
> to "length-extension" attack. They called it "SHA256D".


``` ruby
hash256( '6fe6b145a3908a4d6616b13c1109717add8672c900' )
#=> "02335f08b8fe4ddad263a50b7a33c5d38ea1cbd8fd2056a1320a3ddece541711"
```

#### Base58 Encoding / Decoding Helpers

**BASE58**

Base58 encoding / decoding with leading zero bytes (in hex or binary strings) getting encoded from `00` to `1` and back:

``` ruby
base58( "516b6fcd0f" )    #=> "ABnLTmg"
base58( "00000000000000000000123456789abcdef0" )   #=> "111111111143c9JGph3DZ"
# or with optional 0x or 0X prefix
base58( "0x516b6fcd0f" )  #=> "ABnLTmg"
base58( "0x00000000000000000000123456789abcdef0" ) #=> "111111111143c9JGph3DZ"

unbase58( "ABnLTmg" )  #=> "516b6fcd0f"
unbase58( "111111111143c9JGph3DZ" ) #=> "00000000000000000000123456789abcdef0"
```


**BASE58CHECK -  BASE58(X || SHA256(SHA256(X))[:4])**

Base58 encoding with an extra 4-byte secure hash checksum.

``` ruby
base58check( "516b6fcd0f" )  #=> "237LSrY9NUUas"
base58check( "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31" ) #=> "1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs"

unbase58check( "237LSrY9NUUas" )   #=> "516b6fcd0f"
unbase58check( "1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs" )   #=> "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31"
```



### Public Key Signature Algorithms


**Elliptic Curve Digital Signature Algorithm (ECDSA)**


Private Key

An ECDSA (Elliptic Curve Digital Signature Algorithm) private key is a random number between 1 and the order of the elliptic curve group.


``` ruby
# Auto-generate (random) private key
private_key = EC::PrivateKey.generate    # by default uses Secp256k1 curve (used in Bitcoin and Ethereum)

private_key.to_i
#=> 29170346885894798724849267297784761178669026868482995474159965944722616190552
private_key.to_s
#=> "407dd4ccde53d30f3a9cda74ceccb247f3997466964786b59e4d68e93e8f8658"
```


Derive / (Auto-)Calculate the Public Key - Enter Elliptic Curve (EC) Cryptography

The public key (`K`) are two numbers (that is, a point with the coordinates x and y) computed by multiplying
the generator point (`G`) of the curve with the private key (`k`) e.g. `K=k*G`.
This is equivalent to adding the generator to itself `k` times.
Magic?
Let's try:


``` ruby
# This private key is just an example. It should be much more secure!
private_key = EC::PrivateKey.new( 1234 )   # by default uses Secp256k1 curve (used in Bitcoin and Ethereum)

public_key =  private_key.public_key   ## the "magic" one-way K=k*G curve multiplication (K=public key,k=private key, G=generator point)
point = public_key.point

point.x
#=> 102884003323827292915668239759940053105992008087520207150474896054185180420338
point.y
#=> 49384988101491619794462775601349526588349137780292274540231125201115197157452

point.x.to_s(16)
#=> "e37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f2"
point.y.to_s(16)
#=> "6d2ee9a82d4158f164ae653e9c6fa7f982ed8c94347fc05c2d068ff1d38b304c"
```


Sign a transaction with an (elliptic curve) private key:

``` ruby
# Step 1 - Calculate the Transaction (tx) Hash
tx = 'from: Alice  to: Bob     cryptos: 43_000_000_000'
txhash = sha256( tx )

# Step 2 - Get the Signer's Private key
private_key = EC::PrivateKey.new( 1234 )     # This private key is just an example. It should be much more secure!

# Sign!
signature = private_key.sign( txhash )
# -or-
signature = EC.sign( txhash, private_key )

signature.r
#=> 80563021554295584320113598933963644829902821722081604563031030942154621916407
signature.s
#=> 58316177618967642068351252425530175807242657664855230973164972803783751708604

signature.r.to_s(16)
#=> "3306a2f81ad2b2f62ebe0faec129545bc772babe1ca5e70f6e56556b406464c0"
signature.s.to_s(16)
#=> "4fe202bb0835758f514cd4a0787986f8f6bf303df629dc98c5b1a438a426f49a"
```


Verify a signed transaction with an (elliptic curve) public key:

``` ruby
# Step 1 - Calculate the Transaction (tx) Hash
tx = 'from: Alice  to: Bob     cryptos: 43_000_000_000'
txhash = sha256( tx )

# Step 2 - Get the Signer's Public Key
public_key = EC::PublicKey.new(
   102884003323827292915668239759940053105992008087520207150474896054185180420338,
   49384988101491619794462775601349526588349137780292274540231125201115197157452
)

# Step 3 - Get the Transaction's Signature
signature = EC::Signature.new(
  80563021554295584320113598933963644829902821722081604563031030942154621916407,
  58316177618967642068351252425530175807242657664855230973164972803783751708604
)

# Don't Trust - Verify
public_key.verify?( txhash, signature )
# -or-
EC.verify?( txhash, signature, public_key )
#=> true


# or using hexadecimal numbers

public_key = EC::PublicKey.new(
  0xe37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f2,
  0x6d2ee9a82d4158f164ae653e9c6fa7f982ed8c94347fc05c2d068ff1d38b304c
)

signature = EC::Signature.new(
  0x3306a2f81ad2b2f62ebe0faec129545bc772babe1ca5e70f6e56556b406464c0,
  0x4fe202bb0835758f514cd4a0787986f8f6bf303df629dc98c5b1a438a426f49a
)

public_key.verify?( txhash, signature )
# -or-
EC.verify?( txhash, signature, public_key )
#=> true
```


To sum up:

- The (raw) private key is a 256-bit unsigned integer number
- The (raw) public key is a point (x,y), that is, two 256-bit unsigned integer numbers - derived (calculated) from the private key
- A (raw) signature is composed of (r,s), that is, two 256-bit unsigned integer numbers

That's all the magic.





## Real-World Examples / Cookbook

**Bitcon Public Service Announcement:**

> Bitcoin number go up because more people want bitcoin. Bitcoin becomes more and more valuable.
>
> - 1,000 HODLers
> - 10,000 HODLers
> - 100,000 HODLers
> - 1,000,000 HODLers
> - 10,000,000 HODLers
> - 100,000,000 HODLers
> - 1,000,000,000 HODLers
> - 10,000,000,000 HODLers
> - 100,000,000,000 HODLers and on and on
>
> People will come to understand bitcon.
>
> -- Dan McArdle, Bitcoin "There is No Alternative", Bitcoin is the New (Gold) Standard

**[BEWARE: Yes, Bitcoin Is a Ponzi - Learn How the Investment Fraud Works »](https://github.com/openblockchains/bitcoin-ponzi)**



### Bitcoin (BTC), Bitcoin Cash (BCH), Bitcoin Cash Satoshi Vision (BSV), Bitcoin Cash ABC (BCHA)

- [Derive the Bitcoin (Elliptic Curve) Public Key from the Private Key](#derive-the-bitcoin-elliptic-curve-public-key-from-the-private-key)
- [Generate the Bitcoin (Base58) Address from the (Elliptic Curve) Public Key](#generate-the-bitcoin-base58-address-from-the-elliptic-curve-public-key)
- [Encode the Bitcoin Private Key in the Wallet Import Format (WIF)](#encode-the-bitcoin-private-key-in-the-wallet-import-format-wif)

### Ethereum

- [Derive the Ethereum (Elliptic Curve) Public Key from the Private Key](#derive-the-ethereum-elliptic-curve-public-key-from-the-private-key)
- [Generate the Ethereum Address from the (Elliptic Curve) Public Key](#generate-the-ethereum-address-from-the-elliptic-curve-public-key)


 o o o

<!-- start examples --->


### Derive the Bitcoin (Elliptic Curve) Public Key from the Private Key

A private key in bitcoin is a 32-byte (256-bit) unsigned / positive integer number.

Or more precise the private key is a random number between 1
and the order of the elliptic curve secp256k1.

``` ruby
EC::SECP256K1.order
#=> 115792089237316195423570985008687907852837564279074904382605163141518161494337

# or in hexadecimal (base16)
EC::SECP256K1.order.to_s(16)
#=> "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141"
```

#### Step 1 - Let's generate a private key

``` ruby
private_key = EC::PrivateKey.generate     # alice
private_key.to_i
#=> 50303382071965675924643368363408442017264130870580001935435312336103014915707
private_key.to_s
#=> "6f36b48dd130618049ca27e1909debdf3665cf0df0ade0986f0c50123107de7b"

private_key = EC::PrivateKey.generate     # bob
private_key.to_i
#=> 96396065671557366547785856940504404648366202869823009146014078671352808008442
private_key.to_s
#=> "d51e3d5ce8fbc6e574cf78d1c46e8936c26f38b002b954d0eac8aef195d6eafa"
```

Or use your own (secure) random generator.
Trivia Note: The smallest possible (BUT HIGHLY UNSECURE)
private key is 1 (not 0).

``` ruby
def generate_key
  1 + SecureRandom.random_number( EC::SECP256K1.order - 1 )
end

generate_key         # alice
#=> 66010624277151619503613090016410344678572543187504521309126248385615121289833

generate_key         # bob
#=> 10004433477200726182517873544056418402326985168039465080040800405880945722868
```


Aside:  What's Base 6? Let's Roll the Dice

An important part of creating a private key is ensuring the random number
is truly random.
Physical randomness is better than computer generated pseudo-randomness.
The easiest way to generate physical randomness is with a dice.
To create a private key you only need one six-sided die
which you roll ninety nine times.
Stopping each time to record the value of the die.
When recording the values follow these rules: 1=1, 2=2, 3=3, 4=4, 5=5, 6=0.
By doing this you are recording the big random number, your private key,
in base 6 format.

``` ruby
def roll_dice
  SecureRandom.random_number( 6 ) ##  returning 0,1,2,3,4, or 5
end

priv_base6 = 99.times.reduce('') { |buf,_| buf << roll_dice.to_s }
#=> "413130205513310000115530450343345150251504444013455422453552225503020102150031231134314351124254004"
```

Exercise:
Turn the ninety nine character base 6 private key into a base 10 or base 16 number.

``` ruby
priv = priv_base6.to_i(6)  ## convert to decimal (base 10) from roll-the-dice (base 6) string
#=> 77254760463198588454157792320308725646096652667800343330432100522222375944308
priv.to_s(16)
#=> "aacca516ccbf72dac2c4c447b9f64d12855685e99810ffcf7763a12da6c04074"
```


Aside:  What's Base 2? Let's Flip A Coin - Heads or Tails?

Triva Quiz: For an (unsigned) 256-bit number - how many times
do you need to flip the coin?




#### Step 2 - Let's derive / calculate the public key from the private key - Enter elliptic curve (EC) cryptography

The public key (`K`) are two numbers (that is, a point with the coordinates x and y) computed by multiplying
the generator point (`G`) of the curve with the private key (`k`) e.g. `K=k*G`.
This is equivalent to adding the generator to itself `k` times.
Magic?
Let's try:


``` ruby
# note: by default uses Secp256k1 curve (used in Bitcoin)
private_key = EC::PrivateKey.new( 50303382071965675924643368363408442017264130870580001935435312336103014915707 )

public_key =  private_key.public_key   ## the "magic" one-way K=k*G curve multiplication (K=public key,k=private key, G=generator point)
point = public_key.point

point.x
#=> 17761672841523182714332746445483761684317159074072585653954580096478387916431
point.y
#=> 81286693084077906561204577435230199871025343781583806206090259868058973358862
```

and convert the point to the compressed or uncompressed
Standards for Efficient Cryptography (SEC)
format used in Bitcoin:

``` ruby
point.to_s( :compressed )
#=> "022744c02580b4905349bc481a60c308c2d98d823d44888835047f6bc5c38c4e8f"
point.to_s( :uncompressed )
#=> "042744c02580b4905349bc481a60c308c2d98d823d44888835047f6bc5c38c4e8fb3b6a34b90a571f6c2a1113dd5ff4576f61bbf3e970a6e148fa02bf9eb7bcb0e"
```


References

- [Private key @ Learn me a bitcoin](https://learnmeabitcoin.com/technical/private-key)
- [Public key @ Learn me a bitcoin](https://learnmeabitcoin.com/technical/public-key)


### Generate the Bitcoin (Base58) Address from the (Elliptic Curve) Public Key

Let's follow the steps from [How to create Bitcoin Address](https://en.bitcoin.it/wiki/Technical_background_of_version_1_Bitcoin_addresses#How_to_create_Bitcoin_Address):

``` ruby
# Lets start with the public key ("raw" hex string encoded)
pk = "0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352"

# 1. Perform SHA-256 hashing on the public key
step1 = sha256( pk )
#=> "0b7c28c9b7290c98d7438e70b3d3f7c848fbd7d1dc194ff83f4f7cc9b1378e98"

# 2. Perform RIPEMD-160 hashing on the result of SHA-256
step2 = ripemd160( step1 )
#=> "f54a5851e9372b87810a8e60cdd2e7cfd80b6e31"

# 3. Add version byte in front of RIPEMD-160 hash (0x00 for Main Network)
step3 = "00" + step2
#=> "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31"

# 4. Perform SHA-256 hash on the extended RIPEMD-160 result
step4 = sha256( step3 )
#=> "ad3c854da227c7e99c4abfad4ea41d71311160df2e415e713318c70d67c6b41c"

# 5. Perform SHA-256 hash on the result of the previous SHA-256 hash
step5 = sha256( step4 )
#=> "c7f18fe8fcbed6396741e58ad259b5cb16b7fd7f041904147ba1dcffabf747fd"

# 6. Take the first 4 bytes of the second SHA-256 hash. This is the address checksum
step6 = step5[0..7]      # note: 4 bytes in hex string are 8 digits/chars
#=> "c7f18fe8"

# 7. Add the 4 checksum bytes from step 6 at the end of
#    extended RIPEMD-160 hash from step 3.
#    This is the 25-byte binary Bitcoin Address.
step7 = step3 + step6
#=> "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31c7f18fe8"

# 8. Convert the result from a byte string into a base58 string using Base58 encoding.
#  This is the most commonly used Bitcoin Address format.
addr  = base58( step7 )
#=> "1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs"
```

Or let's try again with the shortcut helpers:

- `HASH160     -  RMD160(SHA256(X))`
- `BASE58CHECK -  BASE58(X || SHA256(SHA256(X))[:4])`

``` ruby
# Lets start with the public key ("raw" hex string encoded)
pk = "0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352"

# 1. Perform HASH-160 hashing on the public key
#    a) Perform SHA-256 hashing on the public key
#    b) Perform RIPEMD-160 hashing on the result of SHA-256
step1 = hash160( pk )
#=> "f54a5851e9372b87810a8e60cdd2e7cfd80b6e31"

# 2. Add version byte in front of RIPEMD-160 hash (0x00 for Main Network)
step2 = "00" + step1
#=> "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31"

# 3. Encode with BASE58CHECK
#    a) Perform SHA-256 hash on the extended RIPEMD-160 result
#    b) Perform SHA-256 hash on the result of the previous SHA-256 hash
#    c) Take the first 4 bytes of the second SHA-256 hash. This is the address checksum
#    d) Add the 4 checksum bytes at the end of
#       extended RIPEMD-160 hash from step 2.
#       This is the 25-byte binary Bitcoin Address.
#    e) Convert the result from a byte string into a base58 string
#       using Base58 encoding.
#       This is the most commonly used Bitcoin Address format.
addr  = base58check( step2 )
#=> "1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs"
```


References

- [How to create Bitcoin Address](https://en.bitcoin.it/wiki/Technical_background_of_version_1_Bitcoin_addresses#How_to_create_Bitcoin_Address)
- [Ruby Quiz #15 - Generate the Bitcoin (Base58) Address from the (Elliptic Curve) Public Key](https://github.com/planetruby/quiz/tree/master/015)



### Encode the Bitcoin Private Key in the Wallet Import Format (WIF)


A Wallet Import Format (WIF) private key is a standard private key, but with a few added extras:

- Version Byte prefix - The network the private key is to be used on.
  - `0x80` = Mainnet
  - `0xEF` = Testnet
- Compression Byte suffix (optional) - Flag if the private key is used to create a compressed public key.
  - `0x01`
- Checksum - Useful for detecting errors/typos when you type out your private key; calculated using the first 4 bytes of the double sha256 hash `SHA256(SHA256(X))[:4]`.

This is all then converted to Base58, which shortens the string and makes it easier to transcribe.

``` ruby
privatekey  = "ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b508258739cb013db2"
extended = "80" + privatekey + "01"
#=> "80ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b508258739cb013db201"
checksum = hash256( extended )[0..7]
#=> "66557e53"
extendedchecksum = extended + checksum
#=> "80ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b508258739cb013db20166557e53"
wif = base58( extendedchecksum )
#=> "L5EZftvrYaSudiozVRzTqLcHLNDoVn7H5HSfM9BAN6tMJX8oTWz6"
```

Or let's try again with the base58check (`BASE58(X || SHA256(SHA256(X))[:4])`) shortcut helper:

``` ruby
privatekey = "ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b508258739cb013db2"
extended   = "80" + privatekey + "01"
#=> "80ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b508258739cb013db201"
wif = base58check( extended )
#=> "L5EZftvrYaSudiozVRzTqLcHLNDoVn7H5HSfM9BAN6tMJX8oTWz6"
```

References

- [How to create a WIF private key @ Learn me a bitcoin](https://learnmeabitcoin.com/technical/wif)
- [Private key to WIF @ Wallet import format](https://en.bitcoin.it/wiki/Wallet_import_format)


Bonus:  Bitcon Tip - How to Buy Bitcoin (The CO₂-Friendly Way)

> 1. Take one $50 bill, five $10 bills, or ten $5 bills (I wouldn't recommend change - stay with paper money).
> 2. Go to the bathroom.
> 3. Lift the lid of the loo.
> 4. Throw money in.
> 5. Flush down water.
>
> Congrats! You just purchased $50 worth of Bitcoin - without fucking the planet!
>
>  -- Trolly McTrollface, Bitcon Greater Fool Court Jester

Read more [Crypto Quotes »](https://github.com/openblockchains/crypto-quotes)




### Derive the Ethereum (Elliptic Curve) Public Key from the Private Key

A private key in ethereum is a 32-byte (256-bit) unsigned / positive integer number.

Or more precise the private key is a random number between 1
and the order of the elliptic curve secp256k1.


``` ruby
EC::SECP256K1.order
#=> 115792089237316195423570985008687907852837564279074904382605163141518161494337

# or in hexadecimal (base16)
EC::SECP256K1.order.to_s(16)
#=> "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141"
```

Note: A "raw" ethereum private key is the same as in bitcoin
using the same elliptic curve secp256k1.
See [Derive the Bitcoin (Elliptic Curve) Public Key from the Private Key](#derive-the-bitcoin-elliptic-curve-public-key-from-the-private-key) above.



#### Step 1 - Let's generate a private key

``` ruby
private_key = EC::PrivateKey.generate     # alice
private_key.to_i
#=> 50303382071965675924643368363408442017264130870580001935435312336103014915707
private_key.to_s
#=> "6f36b48dd130618049ca27e1909debdf3665cf0df0ade0986f0c50123107de7b"

private_key = EC::PrivateKey.generate     # bob
private_key.to_i
#=> 96396065671557366547785856940504404648366202869823009146014078671352808008442
private_key.to_s
#=> "d51e3d5ce8fbc6e574cf78d1c46e8936c26f38b002b954d0eac8aef195d6eafa"
```

Or use your own (secure) random number.
Let's follow along the example
in the [Mastering Ethereum book](https://github.com/ethereumbook/ethereumbook/blob/develop/04keys-addresses.asciidoc#generating-a-private-key-from-a-random-number) and let's use the random number:
`0xf8f8a2f43c8376ccb0871305060d7b27b0554d2cc72bccf41b2705608452f315`.

``` ruby
private_key = EC::PrivateKey.new( 0xf8f8a2f43c8376ccb0871305060d7b27b0554d2cc72bccf41b2705608452f315 )
private_key.to_i
#=> 112612889188223089164322846106333497020645518262799935528047458345719983960853
private_key.to_s
#=> "f8f8a2f43c8376ccb0871305060d7b27b0554d2cc72bccf41b2705608452f315"
```

#### Step 2 - Let's derive / calculate the public key from the private key - Enter elliptic curve (EC) cryptography

The public key (`K`) are two numbers (that is, a point with the coordinates x and y) computed by multiplying
the generator point (`G`) of the curve with the private key (`k`) e.g. `K=k*G`.
This is equivalent to adding the generator to itself `k` times.
Magic?
Let's try:


``` ruby
# note: by default uses Secp256k1 curve (used in Ethereum)
private_key = EC::PrivateKey.new( 0xf8f8a2f43c8376ccb0871305060d7b27b0554d2cc72bccf41b2705608452f315 )

public_key =  private_key.public_key   ## the "magic" one-way K=k*G curve multiplication (K=public key,k=private key, G=generator point)
point = public_key.point

point.x
#=> 17761672841523182714332746445483761684317159074072585653954580096478387916431
point.y
#=> 81286693084077906561204577435230199871025343781583806206090259868058973358862

# or in hexa(decimal) - base 16
point.x.to_s(16)
#=> "6e145ccef1033dea239875dd00dfb4fee6e3348b84985c92f103444683bae07b"
point.y.to_s(16)
#=> "83b5c38e5e2b0c8529d7fa3f64d46daa1ece2d9ac14cab9477d042c84c32ccd0"
```

and convert the point to the raw uncompressed
format used in Ethereum:

``` ruby
## add together the two points (x,y) in a hex string
"%64x%64x" % [point.x, point.y]
#=> "6e145ccef1033dea239875dd00dfb4fee6e3348b84985c92f103444683bae07b83b5c38e5e2b0c8529d7fa3f64d46daa1ece2d9ac14cab9477d042c84c32ccd0"

# or
("%64x" % point.x) + ("%64x" % point.y)
#=> "6e145ccef1033dea239875dd00dfb4fee6e3348b84985c92f103444683bae07b83b5c38e5e2b0c8529d7fa3f64d46daa1ece2d9ac14cab9477d042c84c32ccd0"
```

References

- [Keys and Addresses in Mastering Ethereum](https://github.com/ethereumbook/ethereumbook/blob/develop/04keys-addresses.asciidoc#keys-and-addresses)



### Generate the Ethereum Address from the (Elliptic Curve) Public Key

Let's again follow along the example
in the [Mastering Ethereum book](https://github.com/ethereumbook/ethereumbook/blob/develop/04keys-addresses.asciidoc#ethereum-addresses) and let's (re)use the public key (from above):


Step 1: Use the keccak256 hashing function
to calculate the hash of the public key

``` ruby
pub = "6e145ccef1033dea239875dd00dfb4fee6e3348b84985c92f103444683bae07b83b5c38e5e2b0c8529d7fa3f64d46daa1ece2d9ac14cab9477d042c84c32ccd0"
hash = keccak256( pub )
#=> "2a5bc342ed616b5ba5732269001d3f1ef827552ae1114027bd3ecf1f086ba0f9"
```

Step 2: Keep only the last 20 bytes (least significant bytes), this is the Ethereum address

``` ruby
hash[24,40]    ## last 20 bytes of 32 (skip first 12 bytes (12x2=24 hex chars))
hash[-40..-1]  ## -or- last 20 bytes (40 hex chars)
hash[-40,40]   ## -or- last 20 bytes (40 hex chars)
#=> "001d3f1ef827552ae1114027bd3ecf1f086ba0f9"
```

References

- [Keys and Addresses in Mastering Ethereum](https://github.com/ethereumbook/ethereumbook/blob/develop/04keys-addresses.asciidoc#keys-and-addresses)




## Install

Just install the gem:

    $ gem install crypto-lite


## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!

