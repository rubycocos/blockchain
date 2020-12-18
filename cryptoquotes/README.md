> SEC Investor Education:
> - Don't understand an investment?
> - Don't invest in it.

Yes, but what if there's only 21 million of it?

  \- Trolly McTrollface



# Crypto Quotes   - I HODL, you HODL, we HODL! -  BREAKING: BITCOIN JUST BROKE $22 000!

cryptoquotes library / gem - incl. oracle tool to get a random crypto quote of the day on the command line - on the new new "in math we trust" ponzi economics - on get-rich-quick blockchain secrets - on bitcon maximalists, scammers, morons, clowns, shills & bagHODLers and more


* home  :: [github.com/rubycoco/blockchain](https://github.com/rubycoco/blockchain)
* bugs  :: [github.com/rubycoco/blockchain/issues](https://github.com/rubycoco/blockchain/issues)
* gem   :: [rubygems.org/gems/cryptoquotes](https://rubygems.org/gems/cryptoquotes)
* rdoc  :: [rubydoc.info/gems/cryptoquotes](http://rubydoc.info/gems/cryptoquotes)





## Command Line

Use the `oracle` command line tool. Try:

```
$ oracle -h
```

resulting in:

```
Usage: oracle [options]
  Print wise oracle sayings / crypto quotes

  Options:
    -n, --number=NUM                 Number of quotes to print (default: 1)
    -h, --help                       Prints this help
```


Let's give it a try. Ask the oracle (it's free):

```
$ oracle
```

printing:

```
We have not entered "Post Tether" yet.
Tether is still furiously printing digital bucks.
Who believes Bitcoin's price is organic?
It's not - it's a Ponzi, and Tether is its Little Helper.

> Austrian Maximalist comments:
>
> Bitcoin is not a ponzi. It is a monetary network, first of its kind.
> Currently valued at 365 billion dollars. What am I missing?

    - Amy Castor
```

Or lets try:

```
$ oracle -n2
```

printing:

```
A friend of mine, who works in finance, asked me to explain what Tether was.

Short version: Tether is the internal accounting system for
the largest fraud since Madoff's ponzi scheme.

    - Patrick McKenzie


BREAKING: BITCOIN JUST BROKE $22,000!

We have just reached escape velocity.

> Austrian Maximalist I comments:
>
> 1 Bitcoin = 1 Honda Civic
>
> Soon:
>
> 1 Bitcoin = 1 Tesla, then
> 1 Bitcoin = 1 Lambo, then
> 1 Bitcoin = 1 Super Yacht
>
> Austrian Maximalist II comments:
>
> Just keep HODLing until 1 Bitcoin = 1 Moonbase

    - Bitcoiner
```


## Usage in Your Scripts


Yes, you can add the oracle into your own scripts.
Example:

``` ruby
require 'cryptoquotes'

Oracle.say        # or Oracle.says
```

printing


```
Bitcoin user guide:
1. Buy Bitcoin.
2. Never sell Bitcoin.
3. Don't listen to Bitcoin critics.
4. Tell your friends to buy Bitcoin.
5. Tell your friends never to sell Bitcoin.
6. Tell your friends not to listen to Bitcoin critics.
7. Remember that Bitcoin isn't a pyramid scheme.

> Austrian Maximalist comments:
>   8. See super-rich legendary investors like Tudor Jones, Stanley Druckenmiller,
>      Michael Saylor, etc. who wouldn't fall for mere pyramid schemes, buy and hold Bitcoin.

    - Trolly McTrollface
```
or
```
Right now at the all-time high (ATH) no one who has HODL is down. That's a good feeling.
    
I HODL, you HODL, we HODL!
    
> Austrian Maximalist comments:
>
>  I bought at the all-time high (ATH) and I'm UP.

    - Bitcoiner
```

If you want to get quotes in the source format
(in memory)
use the methods from `Quotes`. Example:

```
q = Quotes.random      # get a random quote (as as hash table)
#=> {"quote"=>
#   "Tether is \"too big to fail\" - the entire crypto industry utterly\n" +
#   "depends on it. We just topped twenty billion alleged dollars' worth of tethers ($USDT).\n" +
#   "If you think this is sustainable, you're a fool.\n",
#  "date"=>#<Date: 2020-12-13>,
#  "source"=>"https://twitter.com/davidgerard/status/1338215299737407490",
#  "by"=>"David Gerard"}
```

That's it for now.




## Sources

The crypto quotes sourced from
[100+ Crypto Quotes - On the New New "In Math We Trust" Ponzi Economics - On Get-Rich-Quick Blockchain Secrets - On Bitcon Maximalists, Scammers, Morons, Clowns, Shills & BagHODLers and More»](https://github.com/openblockchains/crypto-quotes)



## Install

Just install the gem:

    $ gem install cryptoquotes


## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
