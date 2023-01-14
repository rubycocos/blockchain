#  Ethers

ethers - "high-level" all-in-one umbrella quick starter gem for easy installation & usage for ethereum & co. (blockchain) contract services in ruby


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/ethers](https://rubygems.org/gems/ethers)
* rdoc  :: [rubydoc.info/gems/ethers](http://rubydoc.info/gems/ethers)



##  Download & Install The Ruby Package(s)

To install use the ruby package manager (also known as rubygems):

```
$ gem install ethers
```



## Usage In Your Ruby Scripts


For now

``` ruby
require 'ethers'
```

is a (convenience) all-in-one short-cut for:

``` ruby
require 'ethlite'
require 'ethlite-contracts'
require 'ethname'
require 'etherscan-lite'
```



### Gems

For now ethers includes / bundles-up:

- [crypto-lite](../crypto-lite) - cryptographic secure hash functions and public key signature algorithms made easy
- [ethlite](../ethlite) - light-weight machinery to query / call ethereum (blockchain contract) services via json-rpc (incl. tuple support)
- [ethlite-contracts](../ethlite-contracts) - pre-packaged ready-to-use "out-of-the-gem" (blockchain) contract services / function calls for ethereum & co
- [ethname](../ethname) - light-weight crowd-sourced "off-chain" ethereum name to (contract) address service / helper (incl. punks v1,v2,v3,v4; phunks v1,v2, synth punks, punk blocks, etc.)  - yes, you can! - add more names / contracts via git ;-)
- [etherscan-lite](../etherscan-lite) - light-weight machinery / helper for the Etherscan (blockchain) JSON HTTP API / web services (note: API key sign-up required)
- [abidoc](../abidoc) - application binary interface (abi) documentation generator for Ethereum & Co. (blockchain) contracts
- [abigen](../abigen) - generate ready-to-use (blockchain) contract services / function calls for ethereum & co. via application binary inferfaces (abis)






and via dependencies pulls-in:

- [digest-lite](../digest-lite) - crypto(graphic) hash functions / classes - Digest::KeccakLite (512bit, 256bit, etc), Digest::SHA3Lite (512bit, 256bit, etc) in "100% pure" ruby "lite" scripts, that is, without any c-extensions and with zero-dependency
- [elliptic](../elliptic) - elliptic curve digital signature algorithm (ECDSA) cryptography with OpenSSL made easy (incl. secp256k1 curve)
- [abicoder](../abicoder) - "lite" application binary interface (abi) encoding / decoding machinery / helper (incl. nested arrays and/or tuples) for Ethereum & Co. (blockchain) contracts with zero-dependencies for easy (re)use
- [abiparser](../abiparser) - application binary interface (abi) parser machinery / helper for Ethereum & Co. (blockchain) contracts



Anything missing? Please, tell.



## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.


