# Ledger Lite

ledger-lite library / gem - hyper ledger book for the distributed blockchain internet era; add your transactions one block at a time; transfer crypto(currencie)s and balance the accounts


* home  :: [github.com/openblockchains/ledger.lite.rb](https://github.com/openblockchains/ledger.lite.rb)
* bugs  :: [github.com/openblockchains/ledger.lite.rb/issues](https://github.com/openblockchains/ledger.lite.rb/issues)
* gem   :: [rubygems.org/gems/ledger-lite](https://rubygems.org/gems/ledger-lite)
* rdoc  :: [rubydoc.info/gems/ledger-lite](http://rubydoc.info/gems/ledger-lite)



## Usage

Let's add some transactions to the (hyper) ledger book:

| From                      | To           |   $ |
|---------------------------|--------------|----:|
| Central Bank (†)          | Vincent      |  11 |
| Vincent                   | Anne         |   3 |
| Anne                      | Julia        |   2 |
| Julia                     | Luuk         |   1 |
|                           |              |     |
| De Nederlandsche Bank (†) | Ruben        |  11 |
| Vincent                   | Max          |   3 |
| Ruben                     | Julia        |   2 |
| Anne                      | Martijn      |   1 |

(†): Mining Transaction - New Dutch Gulden ($) on the Market!



### Use `send` (send payment/transfer money)

```ruby

ledger = Ledger.new

ledger.send( "Central Bank†",          "Vincent", 11 )
ledger.send( "Vincent",                "Anne",     3 )
ledger.send( "Anne",                   "Julia",    2 )
ledger.send( "Julia",                  "Luuk",     1 )

ledger.send( "De Nederlandsche Bank†", "Ruben",   11 )
ledger.send( "Vincent",                "Max",      3 )
ledger.send( "Ruben",                  "Julia",    2 )
ledger.send( "Anne",                   "Martijn",  1 )

pp ledger   ## pp = pretty print

```

resulting in

```
#<LedgerLite::Ledger
 @addr={
   "Vincent" => 5,
   "Anne"    => 0,
   "Julia"   => 3,
   "Luuk"    => 1,
   "Ruben"   => 9,
   "Max"     => 3,
   "Martijn" => 1}>
```

that is, the addr hash holds all addresses (addr) with the account balances
telling you who owns how much:

| Addr(ess)           | Balance $ |
|---------------------|----------:|
| Vincent             |         5 |
| Anne                |         0 |
| Julia               |         3 |
| Luuk                |         1 |
| Ruben               |         9 |
| Max                 |         3 |
| Martijn             |         1 |


### Use `write` to write / add transactions


Or use transaction hashes:

``` ruby
ledger = Ledger.new

ledger.write(   from: "Central Bank†",          to: "Vincent",  amount: 11 )
ledger.write(   from: "Vincent",                to: "Anne",     amount:  3 )
ledger.write(   from: "Anne",                   to: "Julia",    amount:  2 )
ledger.write(   from: "Julia",                  to: "Luuk",     amount:  1 )

ledger.write( { from: "De Nederlandsche Bank†", to: "Ruben",    amount: 11 },
              { from: "Vincent",                to: "Max",      amount:  3 },
              { from: "Ruben",                  to: "Julia",    amount:  2 },
              { from: "Anne",                   to: "Martijn",  amount:  1 } )

pp ledger
```

Or use transaction (tx) classes/structs:

``` ruby
ledger = Ledger.new

ledger.write( Tx.new( "Central Bank†",          "Vincent", 11 ))
ledger.write( Tx.new( "Vincent",                "Anne",     3 ))
ledger.write( Tx.new( "Anne",                   "Julia",    2 ))
ledger.write( Tx.new( "Julia",                  "Luuk",     1 ))

ledger.write( Tx.new( "De Nederlandsche Bank†", "Ruben",   11 ),
              Tx.new( "Vincent",                "Max",      3 ),
              Tx.new( "Ruben",                  "Julia",    2 ),
              Tx.new( "Anne",                   "Martijn",  1 ))

pp ledger
```

Or use the operator `<<` alias for `write`:

```ruby
ledger = Ledger.new

ledger <<  Tx.new( "Central Bank†",          "Vincent", 11 )
ledger <<  Tx.new( "Vincent",                "Anne",     3 )
ledger <<  Tx.new( "Anne",                   "Julia",    2 )
ledger <<  Tx.new( "Julia",                  "Luuk",     1 )

ledger << [Tx.new( "De Nederlandsche Bank†", "Ruben",   11 ),
           Tx.new( "Vincent",                "Max",      3 ),
           Tx.new( "Ruben",                  "Julia",    2 ),
           Tx.new( "Anne",                   "Martijn",  1 )]

pp ledger
```


Or use blocks of transaction hashes:

``` ruby

ledger = Ledger.new

ledger.write( Block.new( { from: "Central Bank†",          to: "Vincent",    amount: 11 },
                         { from: "Vincent",                to: "Anne",       amount:  3 },
                         { from: "Anne",                   to: "Julia",      amount:  2 },
                         { from: "Julia",                  to: "Luuk",       amount:  1 } ),
              Block.new( { from: "De Nederlandsche Bank†", to: "Ruben",      amount: 11 },
                         { from: "Vincent",                to: "Max",        amount:  3 },
                         { from: "Ruben",                  to: "Julia",      amount:  2 },
                         { from: "Anne",                   to: "Martijn",    amount:  1 } ))

pp ledger
```


Or use blocks of transaction classes/structs:

``` ruby
ledger = Ledger.new

ledger.write( Block.new( Tx.new( "Central Bank†",          "Vincent",  11 ),
                         Tx.new( "Vincent",                "Anne",      3 ),
                         Tx.new( "Anne",                   "Julia",     2 ),
                         Tx.new( "Julia",                  "Luuk",      1 )),
              Block.new( Tx.new( "De Nederlandsche Bank†", "Ruben",    11 ),
                         Tx.new( "Vincent",                "Max",       3 ),
                         Tx.new( "Ruben",                  "Julia",     2 ),
                         Tx.new( "Anne",                   "Martijn",   1 )))

pp ledger
```

Or use blocks of transaction classes/structs (with keyword arguments):

```ruby
ledger = Ledger.new

ledger.write( Block.new( Tx.new( from: "Central Bank†",          to: "Vincent", amount: 11 ),
                         Tx.new( from: "Vincent",                to: "Anne",    amount:  3 ),
                         Tx.new( from: "Anne",                   to: "Julia",   amount:  2 ),
                         Tx.new( from: "Julia",                  to: "Luuk",    amount:  1 )),
              Block.new( Tx.new( from: "De Nederlandsche Bank†", to: "Ruben",   amount: 11 ),
                         Tx.new( from: "Vincent",                to: "Max",     amount:  3 ),
                         Tx.new( from: "Ruben",                  to: "Julia",   amount:  2 ),
                         Tx.new( from: "Anne",                   to: "Martijn", amount:  1 )))

pp ledger
```

# Bonus: Track Commodities, Collectibles or Assets

Ledger Lite lets you design / create your own transactions. For example, let's use
`from`, `to`, `qty` (quantity) and `name` (of commodity, collectible or asset).
Override the `Ledger#unpack` method for "unpacking" arguments from transactions
and the `Ledger#send` method for "committing" transactions:


``` ruby
def unpack( tx )
  ## "unpack" from, to, qty, name values
  if tx.is_a?( Hash )   ## support hashes
    from   = tx[:from]
    to     = tx[:to]
    qty    = tx[:qty]
    name   = tx[:name]
  else   ## assume it's a transaction (tx) struct/class
    from   = tx.from
    to     = tx.to
    qty    = tx.qty
    name   = tx.name
  end
  [from,to,qty,name]
end
```

and

``` ruby
def send( from, to, qty, name )
  if sufficient?( from, qty, name )
    if self.class.config.coinbase?( from )
      # note: coinbase has unlimited supply!! magic happens here
    else
      @addr[ from ][ name ] -= qty
    end
    @addr[ to ] ||= {}     ## make sure addr exists (e.g. init with empty hash {})
    @addr[ to ][ name ] ||= 0
    @addr[ to ][ name ] += qty
  end
end
```

Now use the ledger with the new transaction format like:


``` ruby
ledger = Ledger.new

ledger.send( "Keukenhof†",  "Vincent", 11, "Tulip Admiral van Eijck" )
ledger.send( "Vincent",     "Anne",     3, "Tulip Admiral van Eijck" )
ledger.send( "Anne",        "Julia",    2, "Tulip Admiral van Eijck" )
ledger.send( "Julia",       "Luuk",     1, "Tulip Admiral van Eijck" )

ledger.send( "Dutchgrown†", "Ruben",   11, "Tulip Semper Augustus"  )
ledger.send( "Vincent",     "Max",      3, "Tulip Admiral van Eijck" )
ledger.send( "Ruben",       "Julia",    2, "Tulip Semper Augustus" )
ledger.send( "Anne",        "Martijn",  1, "Tulip Admiral van Eijck" )

pp ledger   ## pp == pretty print
```

resulting in:

```
#<LedgerLite::Ledger
 @addr={
   "Vincent" => {"Tulip Admiral van Eijck" => 5},
   "Anne"    => {"Tulip Admiral van Eijck" => 0},
   "Julia"   => {"Tulip Admiral van Eijck" => 1, "Tulip Semper Augustus" => 2},
   "Luuk"    => {"Tulip Admiral van Eijck" => 1},
   "Ruben"   => {"Tulip Semper Augustus"   => 9},
   "Max"     => {"Tulip Admiral van Eijck" => 3},
   "Martijn" => {"Tulip Admiral van Eijck" => 1}}>
```

Or use blocks of transaction classes/structs (with keyword arguments):


``` ruby
ledger = Ledger.new

ledger.write( Block.new( Tx.new( from: "Keukenhof†",  to: "Vincent", qty: 11, name: "Tulip Admiral van Eijck" ),
                         Tx.new( from: "Vincent",     to: "Anne",    qty:  3, name: "Tulip Admiral van Eijck" ),
                         Tx.new( from: "Anne",        to: "Julia",   qty:  2, name: "Tulip Admiral van Eijck" ),
                         Tx.new( from: "Julia",       to: "Luuk",    qty:  1, name: "Tulip Admiral van Eijck" )),
              Block.new( Tx.new( from: "Dutchgrown†", to: "Ruben",   qty: 11, name: "Tulip Semper Augustus" ),
                         Tx.new( from: "Vincent",     to: "Max",     qty:  3, name: "Tulip Admiral van Eijck" ),
                         Tx.new( from: "Ruben",       to: "Julia",   qty:  2, name: "Tulip Semper Augustus" ),
                         Tx.new( from: "Anne",        to: "Martijn", qty:  1, name: "Tulip Admiral van Eijck" )))

pp ledger
```

And so on and on.




## Ledger Lite in the Real World

- [**centralbank**](https://github.com/openblockchains/centralbank) - command line tool (and core library) - print your own money / cryptocurrency; run your own federated central bank nodes on the blockchain peer-to-peer over HTTP; revolutionize the world one block at a time
- [**tulipmania**](https://github.com/openblockchains/tulipmania) - command line tool (and core library) - tulips on the blockchain; learn by example from the real world (anno 1637) - buy! sell! hodl! enjoy the beauty of admiral of admirals, semper augustus, and more; run your own hyper ledger tulip exchange nodes on the blockchain peer-to-peer over HTTP; revolutionize the world one block at a time
- [**shilling**](https://github.com/bitshilling/bitshilling.tools) - command line tool (and core library) - shilling (or schilling) on the blockchain! rock-solid alpine dollar from austria; print (mine) your own shillings; run your own federated shilling central bank nodes w/ public distributed (hyper) ledger book on the blockchain peer-to-peer over HTTP; revolutionize the world one block at a time
- You? Add your tool / service



## References

[**Programming Cryptocurrencies and Blockchains (in Ruby)**](http://yukimotopress.github.io/blockchains) by Gerald Bauer et al, 2018, Yuki & Moto Press


## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `ledger-lite` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
