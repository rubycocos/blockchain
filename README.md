# Blockchain Lite (Ruby Edition)

blockchain-lite library / gem - build your own blockchain with crypto hashes - revolutionize the world with blockchains, blockchains, blockchains one block at a time

* home  :: [github.com/openblockchains/blockchain.lite.rb](https://github.com/openblockchains/blockchain.lite.rb)
* bugs  :: [github.com/openblockchains/blockchain.lite.rb/issues](https://github.com/openblockchains/blockchain.lite.rb/issues)
* gem   :: [rubygems.org/gems/blockchain-lite](https://rubygems.org/gems/blockchain-lite)
* rdoc  :: [rubydoc.info/gems/blockchain-lite](http://rubydoc.info/gems/blockchain-lite)


## What's a Blockchain?

> A blockchain is a distributed database with
> a list (that is, chain) of records (that is, blocks)
> linked and secured by digital fingerprints
> (that is, crypto hashes).

See the [Awesome Blockchains](https://github.com/openblockchains/awesome-blockchains) page for more.


## Usage

Let's get started.  Build your own blockchain one block at a time.
Example:

``` ruby
require 'blockchain-lite'

b0 = Block.first( 'Genesis' )
b1 = Block.next( b0, 'Transaction Data...' )
b2 = Block.next( b1, 'Transaction Data......' )
b3 = Block.next( b2, 'More Transaction Data...' )

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

### Blocks

[Basic](#basic) •
[Proof-of-Work](#proof-of-work)

Supported block types / classes for now include:

#### Basic

``` ruby
class Block

  attr_reader :index
  attr_reader :timestamp
  attr_reader :data
  attr_reader :previous_hash
  attr_reader :hash

  def initialize(index, data, previous_hash)
    @index         = index
    @timestamp     = Time.now.utc    ## note: use coordinated universal time (utc)
    @data          = data
    @previous_hash = previous_hash
    @hash          = calc_hash
  end

  def calc_hash
    sha = Digest::SHA256.new
    sha.update( @index.to_s + @timestamp.to_s + @data + @previous_hash )
    sha.hexdigest
  end
  ...
end
```

(Source: [basic/block.rb](lib/blockchain-lite/basic/block.rb))


#### Proof-of-Work

``` ruby
class Block

  attr_reader :index
  attr_reader :timestamp
  attr_reader :data
  attr_reader :previous_hash
  attr_reader :nonce        ## proof of work if hash starts with leading zeros (00)
  attr_reader :hash

  def initialize(index, data, previous_hash)
    @index         = index
    @timestamp     = Time.now.utc    ## note: use coordinated universal time (utc)
    @data          = data
    @previous_hash = previous_hash
    @nonce, @hash  = compute_hash_with_proof_of_work
  end

  def calc_hash
    sha = Digest::SHA256.new
    sha.update( @nonce.to_s + @index.to_s + @timestamp.to_s + @data + @previous_hash )
    sha.hexdigest
  end
  ...
end
```

(Source: [proof_of_work/block.rb](lib/blockchain-lite/proof_of_work/block.rb))



### Blockchain Helper / Convenience Wrapper

The `Blockchain` class offers some convenience helpers
for building and checking blockchains. Example:

``` ruby
b = Blockchain.new       # note: will (auto-) add the first (genesis) block

b << 'Transaction Data...'
b << 'Transaction Data......'
b << 'More Transaction Data...'

pp b
```

Check for broken chain links. Example:

``` ruby

b.broken?
# => false      ## blockchain OK
```

or use the `Blockchain` class as a wrapper (pass in the blockchain array):

``` ruby
b0 = Block.first( 'Genesis' )
b1 = Block.next( b0, 'Transaction Data...' )
b2 = Block.next( b1, 'Transaction Data......' )
b3 = Block.next( b2, 'More Transaction Data...' )

blockchain = [b0, b1, b2, b3]


b = Blockchain.new( blockchain )

b.broken?
# => false      ## blockchain OK
```

and so on.




## Install

Just install the gem:

```
$ gem install blockchain-lite
```


## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `blockchain.lite` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
