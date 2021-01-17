# Notes


## Todos

!!! - for hex add check for even number of chars only e.g. 0x00 but NOT 0x0 or such  - why? why not?

- `[str].pack('H*')` will NOT work properly?
- (auto-)add missing 0 to even out ? or report errror??
  e.g.

```
  if hex.length % 2 != 0
    hex = "0" + hex
  end
```


## Base58

- <https://learnmeabitcoin.com/technical/base58>
- <https://en.bitcoin.it/wiki/Base58Check_encoding>



## More ruby base58 gems / libraries

- <https://github.com/dougal/base58> - encoding/decoding integers to/from Base58. Supports Flickr, Bitcoin, and Ripple alphabets - note: defaults to Flickr alphabet!!
    - <https://github.com/dougal/base58/blob/master/lib/base58.rb>
    - <https://github.com/dougal/base58/blob/master/test/test_base58.rb>



- <https://github.com/oleganza/btcruby>
   - <https://github.com/oleganza/btcruby/blob/master/lib/btcruby/base58.rb>
   - <https://github.com/oleganza/btcruby/blob/master/spec/base58_spec.rb>

## More base58 libs in go, elixir, python etc.

- <https://github.com/decred/base58>
  - <https://github.com/decred/base58/blob/master/base58.go>
  - <https://github.com/decred/base58/blob/master/base58_test.go>

- <https://hexdocs.pm/basefiftyeight/B58.html>
  - <https://hexdocs.pm/basefiftyeight/faq.html>

- <https://pypi.org/project/base58/>




