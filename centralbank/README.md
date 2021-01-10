# centralbank

central bank library / gem and command line tool -
print your own money / cryptocurrency; run your own federated central bank nodes on the blockchain peer-to-peer over HTTP; revolutionize the world one block at a time


* home  :: [github.com/rubycoco/blockchain](https://github.com/rubycoco/blockchain)
* bugs  :: [github.com/rubycoco/blockchain/issues](https://github.com/rubycoco/blockchain/issues)
* gem   :: [rubygems.org/gems/centralbank](https://rubygems.org/gems/centralbank)
* rdoc  :: [rubydoc.info/gems/centralbank](http://rubydoc.info/gems/centralbank)



## Command Line

Use the `centralbank` command line tool. Try:

```
$ centralbank -h
```

resulting in:

```
Usage: centralbank [options]

  Wallet options:
    -n, --name=NAME                  Address name (default: Alice)

  Server (node) options:
    -o, --host HOST                  listen on HOST (default: 0.0.0.0)
    -p, --port PORT                  use PORT (default: 4567)
    -h, --help                       Prints this help
```

To start a new (network) node using the default wallet
address (that is, Alice) and the default server host and port settings
use:

```
$ centralbank
```

Stand back ten feets :-) while starting up the machinery.
Ready to print (mine) money on the blockchain?
In your browser open up the page e.g. `http://localhost:4567`. Voila!

![](centralbank.png)



Note: You can start a second node on your computer -
make sure to use a different port (use the `-p/--port` option)
and (recommended)
a different wallet address (use the `-n/--name` option).
Example:

```
$ centralbank -p 5678 -n Bob
```

Happy mining!



## Local Development Setup

For local development - clone or download (and unzip) the centralbank code repo.
Next install all dependencies using bundler with a Gemfile e.g.:

``` ruby
# Gemfile

source "https://rubygems.org"

gem 'sinatra'
gem 'sass'
gem 'blockchain-lite'
```

run

```
$ bundle       ## will use the Gemfile (see above)
```

and now you're ready to run your own centralbank server node. Use the [`config.ru`](config.ru) script for rack:

``` ruby
# config.ru

$LOAD_PATH << './lib'

require 'centralbank'

run Centralbank::Service
```

and startup the money printing machine using rackup - the rack command line tool:

```
$ rackup       ## will use the config.ru - rackup configuration script (see above).
```

In your browser open up the page e.g. `http://localhost:9292`. Voila! Happy mining!




## References

[**Programming Cryptocurrencies and Blockchains (in Ruby)**](http://yukimotopress.github.io/blockchains) by Gerald Bauer et al, 2018, Yuki & Moto Press

And many more @ [**Best of Crypto Books**](https://openblockchains.github.io/crypto-books/) - a collection of books, white papers & more about crypto and blockchains


## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `centralbank` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
