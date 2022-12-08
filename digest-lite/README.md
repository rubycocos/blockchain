# Digest Lite


digest-lite gem - crypto(graphic) hash functions / classes - Digest::KeccakLite (512bit, 256bit, etc), Digest::SHA3Lite (512bit, 256bit, etc) in "100% pure" ruby "lite" scripts, that is, without any c-extensions and with zero-dependency



* home  :: [github.com/rubycoco/blockchain](https://github.com/rubycoco/blockchain)
* bugs  :: [github.com/rubycoco/blockchain/issues](https://github.com/rubycoco/blockchain/issues)
* gem   :: [rubygems.org/gems/digest-lite](https://rubygems.org/gems/digest-lite)
* rdoc  :: [rubydoc.info/gems/digest-lite](http://rubydoc.info/gems/digest-lite)




## Background -  Digest - The Standard Built-In Module / Library For Crypto(graphic) Hash Function Algorithms

In [Ruby's standard Digest module](https://github.com/ruby/digest) the following crypto(graphic) hash function algorithms / classes
are available:

- MD5  (128 bits / 16 bytes) -- Message-Digest Algorithm by RSA Data Security, Inc., described in RFC1321.
- RIPEMD-160 / RMD160  (160 bits / 20 bytes) -- RIPEMD-160 cryptographic hash function, designed by Hans Dobbertin, Antoon Bosselaers, and Bart Preneel.
- SHA1  (160 bits / 20 bytes) -- Secure Hash Algorithm by NIST (the US' National Institute of Standards and Technology), described in FIPS PUB 180-1.
- SHA2 Family -- described in FIPS 180-2.
  - SHA256  (256 bits / 32 bytes)
  - SHA384  (384 bits / 48 bytes)
  - SHA512  (512 bits / 64 bytes)

Example:

``` ruby
require 'digest'

Digest::MD5.hexdigest( 'abc' )
#=> "900150983cd24fb0d6963f7d28e17f72"

Digest::RMD160.hexdigest( 'abc' )
#=> "8eb208f7e05d987a9b044a8e98c6b087f15a0bfc"

Digest::SHA1.hexdigest( 'abc' )
#=> "a9993e364706816aba3e25717850c26c9cd0d89d"

Digest::SHA2.new(256).hexdigest( 'abc' )  # or
Digest::SHA256.hexdigest( 'abc' )
#=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"

Digest::SHA2.new(384).hexdigest 'abc'  # or
Digest::SHA384.hexdigest 'abc'
#=> "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7"

Digest::SHA2.new(512).hexdigest 'abc'   # or
Digest::SHA512.hexdigest 'abc'
#=> "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f"
```


What about the Keccak or SHA3 (family of hash function algorithms)?   Read on.


## Usage


``` ruby
require 'digest-lite'

Digest::KeccakLite.new( 256 ).hexdigest( 'abc' )   # or
Digest::KeccakLite.hexdigest( 'abc', 256 )
#=> "4e03657aea45a94fc7d47ba826c8d667c0d1e6e33a64a036ec44f58fa12d6c45"

Digest::SHA3Lite.new( 224 ).hexdigest( 'abc' )  # or
Digest::SHA3Lite.hexdigest( 'abc', 224 )
#=> "e642824c3f8cf24ad09234ee7d3c766fc9a3a5168d0c94ad73b46fdf"

Digest::SHA3Lite.new( 256 ).hexdigest( 'abc' )  # or
Digest::SHA3Lite.hexdigest( 'abc', 256 )
#=> "3a985da74fe225b2045c172d6bd390bd855f086e3e9d525b46bfe24511431532"

Digest::SHA3Lite.new( 384 ).hexdigest( 'abc' )  # or
Digest::SHA3Lite.hexdigest( 'abc', 384 )
#=> "ec01498288516fc926459f58e2c6ad8df9b473cb0fc08c2596da7cf0e49be4b298d88cea927ac7f539f1edf228376d25"

Digest::SHA3Lite.new( 512 ).hexdigest( 'abc' )  # or
Digest::SHA3Lite.hexdigest( 'abc', 512 )
#=> "b751850b1a57168a5693cd924b6b096e08f621827444f70d884f5d0240d2712e10e116e9192af3c91a7ec57647e3934057340b4cf408d5a56592f8274eec53f0"
```



Note:  To avoid naming conflicts / errors with
`Digest::Keccak` or `Digest::SHA3` as used in alternate
digest gems (with or without c-extensions)  this gem
uses  `Digest::KeccakLite` or `Digest::SHA3Lite`
to let you load different (faster) variants
 at the same time.





## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.

