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


### Transactions

Let's put the transactions from the (hyper) ledger book from [Tulips on the Blockchain!](https://github.com/openblockchains/tulips)
on the blockchain:


| From                | To           | What                      | Qty |
|---------------------|--------------|---------------------------|----:|
| Dutchgrown (†)      | Vincent      | Tulip Bloemendaal Sunset  |  10 |
| Keukenhof (†)       | Anne         | Tulip Semper Augustus     |   7 |
|                     |              |                           |     |
| Flowers (†)         | Ruben        | Tulip Admiral van Eijck   |   5 |
| Vicent              | Anne         | Tulip Bloemendaal Sunset  |   3 |
| Anne                | Julia        | Tulip Semper Augustus     |   1 |
| Julia               | Luuk         | Tulip Semper Augustus     |   1 |
|                     |              |                           |     |
| Bloom & Blossom (†) | Daisy        | Tulip Admiral of Admirals |   8 |
| Vincent             | Max          | Tulip Bloemendaal Sunset  |   2 |
| Anne                | Martijn      | Tulip Semper Augustus     |   2 |
| Ruben               | Julia        | Tulip Admiral van Eijck   |   2 |
|                     |              |                           |     |
| Teleflora (†)       | Max          | Tulip Red Impression      |  11 |
| Anne                | Naomi        | Tulip Bloemendaal Sunset  |   1 |
| Daisy               | Vincent      | Tulip Admiral of Admirals |   3 |
| Julia               | Mina         | Tulip Admiral van Eijck   |   1 |

(†): Grower Transaction - New Tulips on the Market!


```ruby
b0 = Block.first(
        { from: "Dutchgrown", to: "Vincent", what: "Tulip Bloemendaal Sunset", qty: 10 },
        { from: "Keukenhof",  to: "Anne",    what: "Tulip Semper Augustus",    qty: 7  } )

b1 = Block.next( b0,
        { from: "Flowers", to: "Ruben", what: "Tulip Admiral van Eijck",  qty: 5 },
        { from: "Vicent",  to: "Anne",  what: "Tulip Bloemendaal Sunset", qty: 3 },
        { from: "Anne",    to: "Julia", what: "Tulip Semper Augustus",    qty: 1 },
        { from: "Julia",   to: "Luuk",  what: "Tulip Semper Augustus",    qty: 1 } )

b2 = Block.next( b1,
        { from: "Bloom & Blossom", to: "Daisy",   what: "Tulip Admiral of Admirals", qty: 8 },
        { from: "Vincent",         to: "Max",     what: "Tulip Bloemendaal Sunset",  qty: 2 },
        { from: "Anne",            to: "Martijn", what: "Tulip Semper Augustus",     qty: 2 },
        { from: "Ruben",           to: "Julia",   what: "Tulip Admiral van Eijck",   qty: 2 } )
...
```

resulting in:

```
[#<Block:0x2da3da0
  @index              = 0,
  @timestamp          = 1637-09-24 11:40:15,
  @previous_hash      = "0",
  @hash               = "32bd169baebba0b70491b748329ab631c85175be15e1672f924ca174f628cb66",
  @transactions_count = 2,
  @transactions       =
   [{:from=>"Dutchgrown", :to=>"Vincent", :what=>"Tulip Bloemendaal Sunset", :qty=>10},
    {:from=>"Keukenhof",  :to=>"Anne",    :what=>"Tulip Semper Augustus",    :qty=>7}]>,
 #<Block:0x2da2ff0
  @index              = 1,
  @timestamp          = 1637-09-24 11:50:15,
  @previous_hash      = "32bd169baebba0b70491b748329ab631c85175be15e1672f924ca174f628cb66",
  @hash               = "57b519a8903e45348ac8a739c788815e2bd90423663957f87e276307f77f1028",
  @transactions_count = 4,
  @transactions       =
   [{:from=>"Flowers", :to=>"Ruben", :what=>"Tulip Admiral van Eijck",  :qty=>5},
    {:from=>"Vicent",  :to=>"Anne",  :what=>"Tulip Bloemendaal Sunset", :qty=>3},
    {:from=>"Anne",    :to=>"Julia", :what=>"Tulip Semper Augustus",    :qty=>1},
    {:from=>"Julia",   :to=>"Luuk",  :what=>"Tulip Semper Augustus",    :qty=>1}]>,
 #<Block:0x2da2720
  @index              = 2,
  @timestamp          = 1637-09-24 12:00:15,
  @previous_hash      = "57b519a8903e45348ac8a739c788815e2bd90423663957f87e276307f77f1028",
  @hash               = "ec7dd5ea86ab966d4d4db182abb7aa93c7e5f63857476e6301e7e38cebf36568",
  @transactions_count = 4,
  @transactions       =
   [{:from=>"Bloom & Blossom", :to=>"Daisy",   :what=>"Tulip Admiral of Admirals", :qty=>8},
    {:from=>"Vincent",         :to=>"Max",     :what=>"Tulip Bloemendaal Sunset",  :qty=>2},
    {:from=>"Anne",            :to=>"Martijn", :what=>"Tulip Semper Augustus",     :qty=>2},
    {:from=>"Ruben",           :to=>"Julia",   :what=>"Tulip Admiral van Eijck",   :qty=>2}]>,
 ...
```


## Install

Just install the gem:

```
$ gem install blockchain-lite
```


## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `blockchain.lite` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
