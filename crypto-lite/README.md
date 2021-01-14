# crypto-lite - Cryptographic Secure Hash Functions and Public Key Signature Algorithms Made Easy



* home  :: [github.com/rubycoco/blockchain](https://github.com/rubycoco/blockchain)
* bugs  :: [github.com/rubycoco/blockchain/issues](https://github.com/rubycoco/blockchain/issues)
* gem   :: [rubygems.org/gems/crypto-lite](https://rubygems.org/gems/crypto-lite)
* rdoc  :: [rubydoc.info/gems/crypto-lite](http://rubydoc.info/gems/crypto-lite)


## Usage

### Hashing / Hash Functions

SHA256 - Secure Hash Algorithm (SHA) 256-bits (32 bytes)


``` ruby
require 'crypto'      ## or use require 'crypto-lite'

## try abc
sha256( "abc" )             #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( "abc".b )           #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( "\x61\x62\x63" )    #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
sha256( 0x616263 )          #=>  "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"

pp sha256hex( '616263' )    #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
pp sha256hex( '0x616263' )  #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
pp sha256hex( '0X616263' )  #=> "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"


## try a
sha256( "a" )         #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( "\x61" )      #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( 0b01100001 )  #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256( 0x61 )        #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"

sha256hex( '61' )     #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"
sha256hex( '0x61' )   #=> "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"


## try some more
sha256( "Hello, Cryptos!" )  #=> "33eedea60b0662c66c289ceba71863a864cf84b00e10002ca1069bf58f9362d5"
```


and some more.




## Install

Just install the gem:

    $ gem install crypto-lite


## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!

