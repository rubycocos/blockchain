# Base58 Encoding / Decoding

Encode / decode numbers, hex or binary strings (incl. leading zeros) with Bitcoin or Flickr base58 notation / alphabet


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/base58-alphabets](https://rubygems.org/gems/base58-alphabets)
* rdoc  :: [rubydoc.info/gems/base58-alphabets](http://rubydoc.info/gems/base58-alphabets)




## Base58 Alphabets

[Bitcoin](#bitcoin) •
[Flickr](#flickr)



### Bitcoin

The bitcoin notation / alphabet (`123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz`)

The order of it's 58 characters is numeric, uppercase-alpha, lowercase-alpha.



Why use base58 (and not "standard" base64)?

```
// - Don't want 0OIl characters that look the same in some fonts and
//      could be used to create visually identical looking account numbers.
// - A string with non-alphanumeric characters is not as easily accepted as an account number.
// - E-mail usually won't line-break if there's no punctuation to break at.
// - Doubleclicking selects the whole number as one word if it's all alphanumeric.
```

(Source: `base58.h` - Bitcoin Source Code Header Comments)



#### Bitcoin (Base58) Notation

|Num  |Character  |Num  |Character  |Num  |Character  |Num  |Character|
|----:|----------:|----:|----------:|----:|----------:|----:|--------:|
|   0 | **1**     |  16 | **H**     |  32 | **Z**     |  48 | **q**   |
|   1 | **2**     |  17 | **J**     |  33 | **a**     |  49 | **r**   |
|   2 | **3**     |  18 | **K**     |  34 | **b**     |  50 | **s**   |
|   3 | **4**     |  19 | **L**     |  35 | **c**     |  51 | **t**   |
|   4 | **5**     |  20 | **M**     |  36 | **d**     |  52 | **u**   |
|   5 | **6**     |  21 | **N**     |  37 | **e**     |  53 | **v**   |
|   6 | **7**     |  22 | **P**     |  38 | **f**     |  54 | **w**   |
|   7 | **8**     |  23 | **Q**     |  39 | **g**     |  55 | **x**   |
|   8 | **9**     |  24 | **R**     |  40 | **h**     |  56 | **y**   |
|   9 | **A**     |  25 | **S**     |  41 | **i**     |  57 | **z**   |
|  10 | **B**     |  26 | **T**     |  42 | **j**
|  11 | **C**     |  27 | **U**     |  43 | **k**
|  12 | **D**     |  28 | **V**     |  44 | **m**
|  13 | **E**     |  29 | **W**     |  45 | **n**
|  14 | **F**     |  30 | **X**     |  46 | **o**
|  15 | **G**     |  31 | **Y**     |  47 | **p**


Note: `0` (Zero), `O` (Upper-O), `I` (Upper-I), `l` (Lower-L) - these four characters (digits/letters) are
missing in the base 58 alphabets.


**Usage**


Encode / Decode Numbers

```ruby
require 'base58-alphabets'

Base58.encode_num( 100 )        #=> "2j"
Base58.encode_num( 123456789 )  #=> "BukQL"

Base58.decode_num( "2j")        #=> 100
Base58.decode_num( "BukQL" )    #=> 123456789

# or

Base58::Bitcoin.encode_num( 100 )        #=> "2j"
Base58::Bitcoin.encode_num( 123456789 )  #=> "BukQL"

Base58::Bitcoin.decode_num( "2j")        #=> 100
Base58::Bitcoin.decode_num( "BukQL" )    #=> 123456789
```

Encode / Decode Hex Strings

```ruby
Base58.encode_hex( "626262" )      #=> "a3gV"
# Note: The `0x` or `0X` hex prefix is optional.
Base58.encode_hex( "0x626262" )    #=> "a3gV"
Base58.encode_hex( "0X626262" )    #=> "a3gV"
Base58.encode_hex( "516b6fcd0f" )  #=> "ABnLTmg"

Base58.decode_hex( "a3gV" )      #=> "626262"
Base58.decode_hex( "ABnLTmg" )   #=> "516b6fcd0f"

# or

Base58::Bitcoin.encode_hex( "626262" )      #=> "a3gV"
Base58::Bitcoin.encode_hex( "516b6fcd0f" )  #=> "ABnLTmg"

Base58::Bitcoin.decode_hex( "a3gV" )      #=> "626262"
Base58::Bitcoin.decode_hex( "ABnLTmg" )   #=> "516b6fcd0f"
```


What about leading zeros?

Yes, if you use a hex or binary string - the leading zero bytes
will get encoded / decoded (converted from `00` to `1` and back):

```ruby
Base58.encode_hex( "00000000000000000000" ) #=> "1111111111"
Base58.encode_hex( "00000000000000000000123456789abcdef0" ) #=> "111111111143c9JGph3DZ"

Base58.decode_hex( "1111111111" )  #=> "00000000000000000000"
Base58.decode_hex( "111111111143c9JGph3DZ" )  #=> "00000000000000000000123456789abcdef0"
```



Encode / Decode Bin(ary) Strings

```ruby
Base58.encode_bin( "\xCE\xE99\x86".b )   #=>  "6Hknds"

Base58.decode_bin( "6Hknds" )   #=> "\xCE\xE99\x86"

# or

Base58::Bitcoin.encode_bin( "\xCE\xE99\x86".b )   #=>  "6Hknds"

Base58::Bitcoin.decode_bin( "6Hknds" )   #=> "\xCE\xE99\x86"
```




### Flickr

The flickr notation / alphabet (`123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ`)

The order of it's 58 characters is numeric, lowercase-alpha, uppercase-alpha.



Encode / Decode Numbers

```ruby
Base58.format = :flickr    # switch to flickr alphabet (default is bitcoin)

Base58.encode_num( 12345 )     #=> "4ER"

Base58.decode_num( "4ER" )     #=> 12345

# or

Base58::Flickr.encode_num( 12345 )     #=> "4ER"

Base58::Flickr.decode_num( "4ER" )     #=> 12345
```


That's it.



## What's Base 58?

The number of characters you are left with when you use
all the characters in the alphanumeric alphabet,
but remove all the easily mistakable characters like `0`, `O`, `l` and `I`
is... 58.

alphanumeric = `0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz` (62 characters)

base58       = ` 123456789ABCDEFGH JKLMN PQRSTUVWXYZabcdefghijk mnopqrstuvwxyz` (58 characters)



From the Wikipedia:

> Similar to Base64, but modified to avoid both non-alphanumeric
> characters (`+` and `/`) and letters which might look ambiguous
> when printed (`0` - zero, `I` - capital i, `O` - capital o and `l` - lower case L).
> Satoshi Nakamoto invented the base58 encoding scheme when creating bitcoin.
> Some messaging and social media systems line break on non-alphanumeric
> strings. This is avoided by not using URI reserved characters such as `+`.
>
> (Source: [Base58 @ Wikipedia](https://en.wikipedia.org/wiki/Binary-to-text_encoding#Base58))



Why use base58?

The more characters you have in your base, the less you will need to use to represent big numbers.
The bigger your base, the shorter your "number". Example:

``` ruby
base10( 9999 )  #=> 9999      - decimal
base16( 9999 )  #=> 270f      - hexadecimal
base58( 9999 )  #=> 3yQ
```


## Install

Just install the gem:

    $ gem install base58-alphabets



## License

The `base58-alphabets` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
