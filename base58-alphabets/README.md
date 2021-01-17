# Base58 Encoding / Decoding

Encode / decode numbers with Bitcoin or Flickr base58 notation / alphabet


* home  :: [github.com/rubycoco/blockchain](https://github.com/rubycoco/blockchain)
* bugs  :: [github.com/rubycoco/blockchain/issues](https://github.com/rubycoco/blockchain/issues)
* gem   :: [rubygems.org/gems/base58-alphabets](https://rubygems.org/gems/base58-alphabets)
* rdoc  :: [rubydoc.info/gems/base58-alphabets](http://rubydoc.info/gems/base58-alphabets)




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



## Bitcoin

The bitcoin notation / alphabet (`123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz`)


Why use base58 (and not "standard" base64)?

```
// - Don't want 0OIl characters that look the same in some fonts and
//      could be used to create visually identical looking account numbers.
// - A string with non-alphanumeric characters is not as easily accepted as an account number.
// - E-mail usually won't line-break if there's no punctuation to break at.
// - Doubleclicking selects the whole number as one word if it's all alphanumeric.
```

(Source: `base58.h` - Bitcoin Source Code Header Comments)



### Bitcoin (Base58) Notation

|Num  |Character  |Num  |Character  |Num  |Character  |Num  |Character|
|----:|----------:|----:|----------:|----:|----------:|----:|--------:|
| 0   | **1**     |  1  | **2**     |  2  | **3**     |  3  | **4**   |
| 4   | **5**     |  5  | **6**     |  6  | **7**     |  7  | **8**   |
| 8   | **9**     |  9  | **A**     |  10 | **B**     |  11 | **C**   |
| 12  | **D**     |  13 | **E**     |  14 | **F**     |  15 | **G**   |
| 16  | **H**     |  17 | **J**     |  18 | **K**     |  19 | **L**   |
| 20  | **M**     |  21 | **N**     |  22 | **P**     |  23 | **Q**   |
| 24  | **R**     |  25 | **S**     |  26 | **T**     |  27 | **U**   |
| 28  | **V**     |  29 | **W**     |  30 | **X**     |  31 | **Y**   |
| 32  | **Z**     |  33 | **a**     |  34 | **b**     |  35 | **c**   |
| 36  | **d**     |  37 | **e**     |  38 | **f**     |  39 | **g**   |
| 40  | **h**     |  41 | **i**     |  42 | **j**     |  43 | **k**   |
| 44  | **m**     |  45 | **n**     |  46 | **o**     |  47 | **p**   |
| 48  | **q**     |  49 | **r**     |  50 | **s**     |  51 | **t**   |
| 52  | **u**     |  53 | **v**     |  54 | **w**     |  55 | **x**   |
| 56  | **y**     |  57 | **z**     |

Note: `0` (Zero), `O` (Upper-O), `I` (Upper-I), `l` (Lower-L) - these four characters (digits/letters) are
missing in the base 58 alphabets.






## Flickr

The flickr notation / alphabet (`123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ`)






## License

The `base58-alphabets` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
