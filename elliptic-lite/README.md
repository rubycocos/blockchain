# elliptic-lite - elliptic curve cryptography from scratch / zero - start with finite fields, add elliptic curve points and point addition and scalar multiplications, add the elliptic curve digital signature algorithm (ECDSA) using the secp256k1 curve / group to sign and verify messages and more


* home  :: [github.com/rubycoco/blockchain](https://github.com/rubycoco/blockchain)
* bugs  :: [github.com/rubycoco/blockchain/issues](https://github.com/rubycoco/blockchain/issues)
* gem   :: [rubygems.org/gems/elliptic-lite](https://rubygems.org/gems/elliptic-lite)
* rdoc  :: [rubydoc.info/gems/elliptic-lite](http://rubydoc.info/gems/elliptic-lite)




## Usage


Let's start with definining a finite field (mod 13), that is,
`F₁₃ = [0,1,2,3,4,5,6,7,8,9,10,11,12]` where the mod(ulus) is always
a prime number - and the prime number is 13 in this case:



``` ruby
require 'elliptic-lite'


class F₁₃ < FiniteField::Element
  def self.prime() 13; end
end

F₁₃.prime             #=> 13

F₁₃.include?( 0 )     #=> true
F₁₃.include?( 12 )    #=> true
F₁₃.include?( 13 )    #=> false
```

Let's try addition, subtraction, multiplication, exponentiation (power), and division
with finite fields
using the class-level `add`/`sub`/`mul`/`pow`/`div` methods:


``` ruby
F₁₃.add( 7, 12 )   #=> 6
F₁₃.sub( 7, 12 )   #=> 8
F₁₃.mul( 3, 12 )   #=> 10
F₁₃.pow( 3, 3 )    #=> 1
```

Let's try a finite field (mod 19):

``` ruby
F₁₉ = FiniteField.new(19)

F₁₉.div( 7, 5 )    #=> 9
```



And optional in a more object-oriented way with
overloaded math operators (`+`/`-`/`*`/`**`/`/`):

``` ruby
a = F₁₃[7]
b = F₁₃[12]
c = F₁₃[6]
a+b == c       #=> true

c = F₁₃[8]
a-b == c       #=> true

a = F₁₃[3]
b = F₁₃[12]
c = F₁₃[10]
a*b == c       #=> true

a = F₁₃[3]
b = F₁₃[1]
a**3  == b     #=> true
a*a*a == b     #=> true
a*a*a == a**3  #=> true

a = F₁₉[2]
b = F₁₉[7]
c = F₁₉[3]
a/b == c       #=> true


# -or-
F₁₃[7] + F₁₃[12] == F₁₃[6]
F₁₃[7] - F₁₃[12] == F₁₃[8]
F₁₃[3] * F₁₃[12] == F₁₃[10]
F₁₃[3] ** 3               == F₁₃[1]
F₁₃[3] * F₁₃[3] * F₁₃[3]  == F₁₃[1]
F₁₃[3] ** 3               == F₁₃[3] * F₁₃[3] * F₁₃[3]

F₁₉[2] / F₁₉[7] == F₁₉[3]
```











**Bitcon Public Service Announcement:**

> If we all buy Bitcoin from one another at ever higher
> prices we'll all be rich beyond our wildest dreams.
>
> -- Trolly McTrollface

**[BEWARE: Yes, Bitcoin Is a Ponzi - Learn How the Investment Fraud Works »](https://github.com/openblockchains/bitcoin-ponzi)**


## Install

Just install the gem:

    $ gem install elliptic-lite


## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
