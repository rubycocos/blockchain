# Blockchain Lite (Ruby Edition)

blockchainlite gem / library - build your own blockchain with crypto hashes -  revolutionize the world with blockchains, blockchains, blockchains one block at a time

* home  :: [github.com/openblockchains/blockchain.lite.rb](https://github.com/openblockchains/blockchain.lite.rb)
* bugs  :: [github.com/openblockchains/blockchain.lite.rb/issues](https://github.com/openblockchains/blockchain.lite.rb/issues)
* gem   :: [rubygems.org/gems/blockchain-lite](https://rubygems.org/gems/blockchain-lite)
* rdoc  :: [rubydoc.info/gems/blockchain-lite](http://rubydoc.info/gems/blockchain-lite)


## What's a Blockchain?

> A blockchain is a distributed database -
> a list (that is, chain) of records (that is, blocks)
> linked and secured by digital fingerprints
> (that is, hashes also known as (one-way) crypto(graphic) hash digest checksums).

See the [Awesome Blockchains](https://github.com/openblockchains/awesome-blockchains) page for more.


## Usage

Let's get started.  Build your own blockchain one block at a time.
Example:


``` ruby
require 'blockchain-lite'

b0 = Block.first( "Genesis" )
b1 = Block.next( b0, "Transaction Data..." )
b2 = Block.next( b1, "Transaction Data......" )
b3 = Block.next( b2, "More Transaction Data..." )

blockchain = [b0, b1, b2, b3]

pp blockchain

######
#  will pretty print (pp) something like:
#
# [#<Block:0x1eed2a0
#   @index         = 0,
#   @timestamp     = 2017-09-15 20:52:38,
#   @data          = "Genesis",
#   @previous_hash = "0",
#   @hash          ="edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b">,
#  #<Block:0x1eec9a0
#   @index         = 1,
#   @timestamp     = 2017-09-15 20:52:38,
#   @data          = "Transaction Data...",
#   @hash          = "eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743",
#   @previous_hash = "edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b">,
#  #<Block:0x1eec838
#   @index         = 2,
#   @timestamp     = 2017-09-15 20:52:38,
#   @data          = "Transaction Data......",
#   @hash          = "be50017ee4bbcb33844b3dc2b7c4e476d46569b5df5762d14ceba9355f0a85f4",
#   @previous_hash = "eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743">,
#  #<Block:0x1eec6d0
#   @index         = 3,
#   @timestamp     = 2017-09-15 20:52:38
#   @data          = "More Transaction Data...",
#   @hash          = "5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d",
#   @previous_hash = "be50017ee4bbcb33844b3dc2b7c4e476d46569b5df5762d14ceba9355f0a85f4">]
```


## Install

Just install the gem:

    $ gem install blockchain-lite


## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `blockchain.lite` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
