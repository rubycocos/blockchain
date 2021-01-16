# Base32 Encoding / Decoding - 5-Bit Notations / Alphabets - Kai / Crockford / Electrologica


Encode / decode numbers in 5-bit groups (2^5=32)
with Kai, Crockford or Electrologica notation / alphabet


* home  :: [github.com/rubycoco/blockchain](https://github.com/rubycoco/blockchain)
* bugs  :: [github.com/rubycoco/blockchain/issues](https://github.com/rubycoco/blockchain/issues)
* gem   :: [rubygems.org/gems/base32-alphabets](https://rubygems.org/gems/base32-alphabets)
* rdoc  :: [rubydoc.info/gems/base32-alphabets](http://rubydoc.info/gems/base32-alphabets)




[Kai](#kai) •
[Crockford](#crockford) •
[Electrologica](#electrologica)




## Kai

The kai notation / alphabet (`123456789abcdefghijkmnopqrstuvwx`)

Note: Following base56 - the digit-0 and the letter-l
are NOT used in the kai alphabet / notation.

### Kai (Base32) Notation

|Kai    |Binary |Num|Kai    |Binary |Num|Kai    |Binary |Num|Kai    |Binary |Num|
|------:|------:|--:|------:|------:|--:|------:|------:|--:|------:|------:|--:|
| **1** | 00000 | 0 | **9** | 01000 | 8 | **h** | 10000 |16 | **q** | 11000 |24 |
| **2** | 00001 | 1 | **a** | 01001 | 9 | **i** | 10001 |17 | **r** | 11001 |25 |
| **3** | 00010 | 2 | **b** | 01010 | 10 | **j** | 10010 |18 | **s** | 11010 |26 |
| **4** | 00011 | 3 | **c** | 01011 | 11 | **k** | 10011 |19 | **t** | 11011 |27 |
| **5** | 00100 | 4 | **d** | 01100 | 12 | **m** | 10100 |20 | **u** | 11100 |28 |
| **6** | 00101 | 5 | **e** | 01101 | 13 | **n** | 10101 |21 | **v** | 11101 |29 |
| **7** | 00110 | 6 | **f** | 01110 | 14 | **o** | 10110 |22 | **w** | 11110 |30 |
| **8** | 00111 | 7 | **g** | 01111 | 15 | **p** | 10111 |23 | **x** | 11111 |31 |

Note: The digit-0 and the letter-l are NOT used in kai.


### Usage - Encode / Decode

``` ruby
require 'base32-alphabets'


binary = 0b0000000000000000010010100101001010010011000111001110010000001000010111000001010010111101110011100000000101001010000000110001100010000100011010100000110010000000100011000110000000101001010010100110001100010100101000110100101000010010100101011011100111001110  # binary
hex    = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce   # hex

pp binary == hex
# => true

str    = "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff".gsub( ' ', '' )

str2 = Kai.encode( hex )   ## (binary) number to text
pp str
# => "aaaa788522f2agff16617755e979244166677664a9aacfff"
pp str2
# => "aaaa788522f2agff16617755e979244166677664a9aacfff"
pp str == str2
# => true
pp Kai.fmt( str2 )
# => "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"
pp Kai.fmt( hex )   # all-in-one "shortcut" for Kai.fmt( Kai.encode( hex ))
# => "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"

hex2 = Kai.decode( str2 )   ## text to (binary) number
pp hex
# => 512955438081049600613224346938352058409509756310147795204209859701881294
pp hex2
# => 512955438081049600613224346938352058409509756310147795204209859701881294
pp hex == hex2
# => true

pp = Kai.bytes( hex )
# => [9,9,9,9,6,7,7,4,1,1,14,1,9,15,14,14,0,5,5,0,6,6,4,4,13,8,6,8,1,3,3,0,5,5,5,6,6,5,5,3,9,8,9,9,11,14,14,14]
pp = Kai.bytes( str )  # or from a kai string (auto-decodes to hex first)
# => [9,9,9,9,6,7,7,4,1,1,14,1,9,15,14,14,0,5,5,0,6,6,4,4,13,8,6,8,1,3,3,0,5,5,5,6,6,5,5,3,9,8,9,9,11,14,14,14]
```

or


``` ruby
Base32.format = :kai

str = Base32.encode( hex )   ## (binary) number to text
pp str
# => "aaaa788522f2agff16617755e979244166677664a9aacfff"
pp Base32.fmt( str )
# => "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"
pp Base32.fmt( hex )  # all-in-one "shortcut" for Base32.fmt( Base32.encode( hex ))
# => "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"
pp = Base32.decode( str )   ## text to (binary) number
# => 512955438081049600613224346938352058409509756310147795204209859701881294
pp = Base32.bytes( hex )
# => [9,9,9,9,6,7,7,4,1,1,14,1,9,15,14,14,0,5,5,0,6,6,4,4,13,8,6,8,1,3,3,0,5,5,5,6,6,5,5,3,9,8,9,9,11,14,14,14]
pp = Base32.bytes( str )  # or from a kai string (auto-decodes to hex first)
# => [9,9,9,9,6,7,7,4,1,1,14,1,9,15,14,14,0,5,5,0,6,6,4,4,13,8,6,8,1,3,3,0,5,5,5,6,6,5,5,3,9,8,9,9,11,14,14,14]
```


### Why Kai?

The Kai notation / alphabet is named in honor of Kai Turner
who first deciphered the CryptoKitties 256-bit genes in 5-bit groups - thanks!
See [The CryptoKitties Genome Project: On Dominance, Inheritance and Mutation](https://medium.com/@kaigani/the-cryptokitties-genome-project-on-dominance-inheritance-and-mutation-b73059dcd0a4), January 2018.






## Crockford

The crockford notation / alphabet (`0123456789abcdefghjkmnpqrstvwxyz`)

Note: The Crockford Base32 symbol set is a superset of the Base16 (hexadecimal) symbol set
and starts counting at zero (0).


### Crockford (Base32) Notation

|Base32 |Binary |Num|Base32 |Binary |Num|Base32 |Binary |Num|Base32 |Binary |Num|
|------:|------:|--:|------:|------:|--:|------:|------:|--:|------:|------:|--:|
| **0** | 00000 | 0 | **8** | 01000 | 8 | **g** | 10000 |16 | **r** | 11000 |24 |
| **1** | 00001 | 1 | **9** | 01001 | 9 | **h** | 10001 |17 | **s** | 11001 |25 |
| **2** | 00010 | 2 | **a** | 01010 | 10 | **j** | 10010 |18 | **t** | 11010 |26 |
| **3** | 00011 | 3 | **b** | 01011 | 11 | **k** | 10011 |19 | **v** | 11011 |27 |
| **4** | 00100 | 4 | **c** | 01100 | 12 | **m** | 10100 |20 | **w** | 11100 |28 |
| **5** | 00101 | 5 | **d** | 01101 | 13 | **n** | 10101 |21 | **x** | 11101 |29 |
| **6** | 00110 | 6 | **e** | 01110 | 14 | **p** | 10110 |22 | **y** | 11110 |30 |
| **7** | 00111 | 7 | **f** | 01111 | 15 | **q** | 10111 |23 | **z** | 11111 |31 |

Note: 4 of the 26 letters are excluded: I L O U.

- I	Can be confused with 1
- L	Can be confused with 1
- O	Can be confused with 0
- U	Accidental obscenity



### Usage - Encode / Decode

``` ruby
require 'base32-alphabets'


binary = 0b0000000000000000010010100101001010010011000111001110010000001000010111000001010010111101110011100000000101001010000000110001100010000100011010100000110010000000100011000110000000101001010010100110001100010100101000110100101000010010100101011011100111001110  # binary
hex    = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce   # hex

pp binary == hex
# => true

str = "9999 6774 11e1 9fee 0550 6644 d868 1330 5556 6553 9899 beee".gsub( ' ', '' )

str2 = Crockford.encode( hex )   ## (binary) number to text
pp str2
# => "9999677411e19fee05506644d8681330555665539899beee"
pp str == str2
# => true
pp Crockford.fmt( str2 )
# => "9999 6774 11e1 9fee 0550 6644 d868 1330 5556 6553 9899 beee"

hex2 = Crockford.decode( str2 )   ## text to (binary) number
pp hex
# => 512955438081049600613224346938352058409509756310147795204209859701881294
pp hex2
# => 512955438081049600613224346938352058409509756310147795204209859701881294
pp hex == hex2
# => true
```

or


``` ruby
Base32.format = :crockford

str = Base32.encode( hex )   ## (binary) number to text
pp str
# => "9999677411e19fee05506644d8681330555665539899beee"
pp Base32.fmt( str )
# => "9999 6774 11e1 9fee 0550 6644 d868 1330 5556 6553 9899 beee"
pp = Base32.decode( str )   ## text to (binary) number
# => 512955438081049600613224346938352058409509756310147795204209859701881294
```



## Electrologica

The electrologica notation / alphabet (
`00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31`)


### Electrologica (Base32) Notation

|Base32 |Binary |Num|Base32 |Binary |Num|Base32 |Binary |Num|Base32 |Binary |Num|
|------:|------:|--:|------:|------:|--:|------:|------:|--:|------:|------:|--:|
| **00** | 00000 | 0 | **08** | 01000 | 8 | **16** | 10000 |16 | **24** | 11000 |24 |
| **01** | 00001 | 1 | **09** | 01001 | 9 | **17** | 10001 |17 | **25** | 11001 |25 |
| **02** | 00010 | 2 | **10** | 01010 | 10 | **18** | 10010 |18 | **26** | 11010 |26 |
| **03** | 00011 | 3 | **11** | 01011 | 11 | **19** | 10011 |19 | **27** | 11011 |27 |
| **04** | 00100 | 4 | **12** | 01100 | 12 | **20** | 10100 |20 | **28** | 11100 |28 |
| **05** | 00101 | 5 | **13** | 01101 | 13 | **21** | 10101 |21 | **29** | 11101 |29 |
| **06** | 00110 | 6 | **14** | 01110 | 14 | **22** | 10110 |22 | **30** | 11110 |30 |
| **07** | 00111 | 7 | **15** | 01111 | 15 | **23** | 10111 |23 | **31** | 11111 |31 |



### Usage - Encode / Decode

``` ruby
require 'base32-alphabets'


binary = 0b0000000000000000010010100101001010010011000111001110010000001000010111000001010010111101110011100000000101001010000000110001100010000100011010100000110010000000100011000110000000101001010010100110001100010100101000110100101000010010100101011011100111001110  # binary
hex    = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce   # hex

pp binary == hex
# => true

str = "09-09-09-09 06-07-07-04 01-01-14-01 09-15-14-14 00-05-05-00 06-06-04-04 13-08-06-08 01-03-03-00 05-05-05-06 06-05-05-03 09-08-09-09 11-14-14-14".gsub( ' ', '-' )

str2 = Electrologica.encode( hex )   ## (binary) number to text
pp str2
# => "09-09-09-09-06-07-07-04-01-01-14-01-09-15-14-14-00-05-05-00-06-06-04-04-13-08-06-08-01-03-03-00-05-05-05-06-06-05-05-03-09-08-09-09-11-14-14-14"
pp str == str2
# => true
pp Electrologica.fmt( str2 )
# => "09-09-09-09 06-07-07-04 01-01-14-01 09-15-14-14 00-05-05-00 06-06-04-04 13-08-06-08 01-03-03-00 05-05-05-06 06-05-05-03 09-08-09-09 11-14-14-14"

hex2 = Electrologica.decode( str2 )   ## text to (binary) number
pp hex
# => 512955438081049600613224346938352058409509756310147795204209859701881294
pp hex2
# => 512955438081049600613224346938352058409509756310147795204209859701881294
pp hex == hex2
# => true
```

or


``` ruby
Base32.format = :electrologica

str = Base32.encode( hex )   ## (binary) number to text
pp str
# => "09-09-09-09-06-07-07-04-01-01-14-01-09-15-14-14-00-05-05-00-06-06-04-04-13-08-06-08-01-03-03-00-05-05-05-06-06-05-05-03-09-08-09-09-11-14-14-14"
pp Base32.fmt( str )
# => "09-09-09-09 06-07-07-04 01-01-14-01 09-15-14-14 00-05-05-00 06-06-04-04 13-08-06-08 01-03-03-00 05-05-05-06 06-05-05-03 09-08-09-09 11-14-14-14"
pp = Base32.decode( str )   ## text to (binary) number
# => 512955438081049600613224346938352058409509756310147795204209859701881294
```



## Real World Usage

See the [copycats command line tool (and core library)](https://github.com/cryptocopycats/copycats) - crypto cats / kitties collectibles unchained - buy! sell! hodl! sire! - play for free - runs off the blockchain - no ether / gas required


## More Documentation / Articles / Samples

- [Programming Crypto Collectibles Step-by-Step Book / Guide](https://github.com/cryptocopycats/programming-cryptocollectibles) -
Let's start with CryptoKitties & Copycats. Inside Unique Bits & Bytes on the Blockchain...
- [Ruby Quiz - Challenge #8 - Base32 Alphabet](https://github.com/planetruby/quiz/tree/master/008) - Convert the Super "Sekretoooo" 256-Bit CryptoKitties Genome to Kai Notation - Annipurrsary!





## License

The `base32-alphabets` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
