# elliptic - elliptic curve digital signature algorithm (ECDSA) cryptography with OpenSSL made easy (incl. secp256k1 curve)


* home  :: [github.com/rubycoco/blockchain](https://github.com/rubycoco/blockchain)
* bugs  :: [github.com/rubycoco/blockchain/issues](https://github.com/rubycoco/blockchain/issues)
* gem   :: [rubygems.org/gems/elliptic](https://rubygems.org/gems/elliptic)
* rdoc  :: [rubydoc.info/gems/elliptic](http://rubydoc.info/gems/elliptic)




## Usage


### Intro

Did you know? All you need to open up a new account on a blockchain
is an (unsigned) 256-bit / 32-byte integer number.
Yes, that's it.  No questions asked.
The private key is the secret "magic" that unlocks your own bank.


Q: What's the maximum value for a 256-bit / 32-byte integer number
(hint 2^256-1)?

Maximum value of 2^256-1 =

``` ruby
2**256-1
#=> 115792089237316195423570985008687907853269984665640564039457584007913129639935
(2**256-1).to_s.length
#=> 78
```

Yes, that's 78 (!) decimal digits.


Let's (re)try the maximum value for a 256-bit (32-byte) integer number
in hexadecimal (base 16) and binary (base 2) format?

``` ruby
(2**256-1).to_s(16)
#=> "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
(2**256-1).to_s(16).length
#=> 64

(2**256-1).to_s(2)
#=> "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
(2**256-1).to_s(2).length
#=> 256
```

Surprise - a 256-bit number has 256 binary digits (0 and 1s).



BEWARE - Blockchain Bandits!
If you use a low integer number e.g.  1, 2, etc.
your account is guaranteed to get robbed by blockchain bandits in
seconds.

(See [A "Blockchain Bandit" Is Guessing Private Keys and Scoring Millions](https://www.wired.com/story/blockchain-bandit-ethereum-weak-private-keys/)
by Andy Greenberg, Wired Magazine, April 2019)




### Private Key

An ECDSA (Elliptic Curve Digital Signature Algorithm) private key is a random number between 1 and the order of the elliptic curve group.


``` ruby
require 'elliptic'

# Auto-generate (random) private key
private_key = EC::PrivateKey.generate    # by default uses Secp256k1 curve (used in Bitcoin and Ethereum)

private_key.to_i
#=> 72190737707147846840353520312904745954595478835413056312168022784020322830309
```


### (Auto-)Calculate the Public Key - Enter Elliptic Curve (EC) Cryptography

The public key are two numbers (that is, a point with the coordinates x and y) computed by multiplying
the generator point (`G`) of the curve with the private key.
This is equivalent to adding the generator to itself `private_key` times.
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


###  Sign & Verify Transactions

Sign a transaction with an (elliptic curve) private key:

``` ruby
# Step 1 - Calculate the Transaction (tx) Hash
tx = 'from: Alice  to: Bob     cryptos: 43_000_000_000'
txhash = Digest::SHA256.digest( tx )

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
txhash = Digest::SHA256.digest( tx )

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




### Public Key Formats

To get the all-in-one-string
public key from a point with the coordinates x and y
use the
Standards for Efficient Cryptography (SEC)  1) uncompressed format
or the 2) compressed format:


``` ruby
# 1) Uncompressed format (with prefix 04)
#   Convert to 64 hexstring characters (32 bytes) in length

prefix = '04'
pubkey = prefix + "%064x" % point.x + "%064x" % point.y
#=> "04e37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f26d2ee9a82d4158f164ae653e9c6fa7f982ed8c94347fc05c2d068ff1d38b304c"

# 2) Compressed format (with prefix - 02 = even / 03 = odd)
#   Instead of using both x and y coordinates,
#   just use the x-coordinate and whether y is even/odd

prefix = point.y % 2 == 0 ? '02' : '03'
pubkey = prefix + "%064x" % point.x
#=> "02e37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f2"
```

or use the builtin helpers:

``` ruby
# 1) Uncompressed format (with prefix 04)
#   Convert to 64 hexstring characters (32 bytes) in length

point.to_s   # or point.to_s( :uncompressed )
#=> "04e37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f26d2ee9a82d4158f164ae653e9c6fa7f982ed8c94347fc05c2d068ff1d38b304c"

# 2) Compressed format (with prefix - 02 = even / 03 = odd)
#   Instead of using both x and y coordinates,
#   just use the x-coordinate and whether y is even/odd

point.to_s( :compressed )
#=> "02e37648435c60dcd181b3d41d50857ba5b5abebe279429aa76558f6653f1658f2"
```


That's it.




## Aside - Elliptic What?

> Elliptic-curve cryptography (ECC) is
> an approach to public-key cryptography based
> on the algebraic structure of elliptic curves over finite fields.
>
> (Source: [Elliptic-curve cryptography @ Wikipedia](https://en.wikipedia.org/wiki/Elliptic-curve_cryptography))


What's an Elliptic Curve?

![](i/secp256k1.png)

> This is a graph of secp256k1's elliptic curve `y² = x³ + 7`
> over the real numbers.
> Note that because secp256k1 is actually defined over the field Zₚ,
> its graph will in reality look like random scattered points,
> not anything like this.
>
> (Source: [Secp256k1 @ Bitcoin Wiki](https://en.bitcoin.it/wiki/Secp256k1))




**Bitcon Public Service Announcement:**

> If we all buy Bitcoin from one another at ever higher
> prices we'll all be rich beyond our wildest dreams.
>
> -- Trolly McTrollface

**[BEWARE: Yes, Bitcoin Is a Ponzi - Learn How the Investment Fraud Works »](https://github.com/openblockchains/bitcoin-ponzi)**




## Install

Just install the gem:

    $ gem install elliptic


## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
