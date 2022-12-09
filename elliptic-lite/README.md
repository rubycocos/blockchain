# elliptic-lite - elliptic curve cryptography from scratch / zero - start with finite fields, add elliptic curve points and point addition and scalar multiplications, add the elliptic curve digital signature algorithm (ECDSA) using the secp256k1 curve / group to sign and verify messages and more


* home  :: [github.com/rubycocos/blockchain](https://github.com/rubycocos/blockchain)
* bugs  :: [github.com/rubycocos/blockchain/issues](https://github.com/rubycocos/blockchain/issues)
* gem   :: [rubygems.org/gems/elliptic-lite](https://rubygems.org/gems/elliptic-lite)
* rdoc  :: [rubydoc.info/gems/elliptic-lite](http://rubydoc.info/gems/elliptic-lite)




## Usage


### Finite Fields

Let's start with defining a finite field (mod 13), that is,
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



### Elliptic Curves & Elliptic Curve Points (Over Integer Numbers)


Let's define an elliptic curve - `y³ = x² + ax + b` where a is 5 and b is 7:

``` ruby
CURVE_5_7 = Curve.new( a: 5, b: 7 )
```

And let's define a point class - a point being a pair of x/y-coordinates - for the elliptic curve `y³ = x² + 5x + 7` (with `a=5` and `b=7`):

``` ruby
class Point_5_7 < Point
  def self.curve() CURVE_5_7; end
end

p1 = Point_5_7.new( -1, -1 )   # point with x/y coords: -1/-1
p2 = Point_5_7.new( -1, -2 )   # raise ArgumentError!! point NOT on curve

Point_5_7.on_curve?( -1, -1 )  #=> true
Point_5_7.on_curve?( -1, -2 )  #=> false

#-or-
p1 = Point_5_7[ -1, -1 ]
p2 = Point_5_7[ -1, -2 ]

# and the infinity point
inf = Point_5_7[ :infinity ]
inf.infinity?                 #=> true
```

Let's try point addition on the  `y³ = x² + 5x + 7` elliptic curve (with `a=5` and `b=7`):

``` ruby
p1  = Point_5_7[-1, -1]
p2  = Point_5_7[-1,  1]
inf = Point_5_7[ :infinity ]

p1  + inf     #=> Point_5_7[-1,-1]
inf + p2      #=> Point_5_7[-1,1]
p1  + p2      #=> Point_5_7[:infinity]

p1 = Point_5_7[ 2, 5]
p2 = Point_5_7[-1,-1]
p1 + p2       #=> Point_5_7[3,-7]

p1 = Point_5_7[-1,-1]
p1 + p1       #=> Point_5_7[18,77]
```



### Elliptic Curves & Elliptic Points Over Finite Fields

Let's change from "plain vanilla" integer numbers
to finite fields.  Let's try F₂₂₃ - a finite field (mod 223)
where the mod(ulus) is the prime number 223.

``` ruby
class F₂₂₃ < FiniteField::Element
  def self.prime() 223; end
end
```

Let's define an elliptic curve over F₂₂₃ - `y³ = x² + ax + b` where a is 0 and b is 7:

``` ruby
CURVE_F₂₂₃0_7 = Curve.new( a: 0, b: 7, f: F₂₂₃ )
```

And let's define a point class:

``` ruby
class Point_F₂₂₃0_7 < Point
  def self.curve() CURVE_F₂₂₃0_7; end
end
```

And let's try point addition:

``` ruby
p1 = Point_F₂₂₃0_7[ 192, 105 ]
p2 = Point_F₂₂₃0_7[ 17, 56 ]
p1 + p2      #=> Point_F₂₂₃0_7[170,142]

p1 = Point_F₂₂₃0_7[ 170, 142 ]
p2 = Point_F₂₂₃0_7[ 60, 139 ]
p1 + p2      #=> Point_F₂₂₃0_7[220,181]

p1 = Point_F₂₂₃0_7[ 47, 71 ]
p2 = Point_F₂₂₃0_7[ 17, 56 ]
p1 + p2      #=> Point_F₂₂₃0_7[215,68]
```

And finally let's try scalar point multiplication:

``` ruby
p    = Point_F₂₂₃0_7[ 192, 105 ]
p+p     #=> Point_F₂₂₃0_7[49,71]

p    = Point_F₂₂₃0_7[ 143, 98 ]
p+p     #=> Point_F₂₂₃0_7[64,168]

p    = Point_F₂₂₃0_7[ 47, 71 ]
p+p                                        #=> Point_F₂₂₃0_7[36,111]
p+p+p+p                                    #=> Point_F₂₂₃0_7[194,51]
p+p+p+p+p+p+p+p                            #=> Point_F₂₂₃0_7[116,55]
p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p+p  #=> Point_F₂₂₃0_7[:infinity]

#-or-

2*p   #=> Point_F₂₂₃0_7[36,111]
4*p   #=> Point_F₂₂₃0_7[194,51]
8*p   #=> Point_F₂₂₃0_7[116,55]
21*p  #=> Point_F₂₂₃0_7[:infinity]
```

Or let's try the from 1 to inifinity, that is, the order of the group
using the generating point (47/71):

``` ruby
p = Point_F₂₂₃0_7[ 47, 71 ]
(1..21).each do |s|
   product = s*p
   puts " #{s}*#{p.inspect} => #{product.inspect}"
end
```

resulting in:

```
 1*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[47,71]
 2*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[36,111]
 3*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[15,137]
 4*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[194,51]
 5*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[126,96]
 6*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[139,137]
 7*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[92,47]
 8*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[116,55]
 9*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[69,86]
10*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[154,150]
11*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[154,73]
12*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[69,137]
13*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[116,168]
14*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[92,176]
15*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[139,86]
16*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[126,127]
17*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[194,172]
18*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[15,86]
19*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[36,112]
20*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[47,152]
21*Point_F₂₂₃0_7[47,71] => Point_F₂₂₃0_7[:infinity]
```



## What's secp256k1?


Let's use the elliptic curve defined by secp256k1 and in use
for the public-key cryptography by Dodge, Bitcoin, Ethereum and many others.

secp256k1 refers to the parameters of the elliptic curve. The name represents the specific parameters of curve:

- sec: stands for Standards for Efficient Cryptography
- p: indicates that what follows are the parameters of the curve
- 256: length in bits of the field size
- k: Kolbitz curve, as opposed to random. The non-random construction allows for efficient construction
- 1: sequence number


Let's start with the finite field
using a big prime number (almost 2**256), that is,
`2**256 - 2**32 - 977`
or
` 115792089237316195423570985008687907853269984665640564039457584007908834671663`:


``` ruby
class S256Field < FiniteField::Element
  P = 2**256 - 2**32 - 977
  def self.prime() P; end
end
```

Let's define an elliptic curve over  - `y³ = x² + ax + b` where a is 0 and b is 7
and let's define a point class:

``` ruby
class S256Point < Point
  def self.curve() @curve ||= Curve.new( a: 0, b: 7, f: S256Field ); end
end
```

And let's define the group for the generation point (g)
with the order (n):

``` ruby
SECP256K1 = Group.new(
  g: S256Point.new( 0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798,
                    0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8 ),
  n: 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141
)
```

That are all the standard secp256k1 parameters to use the
Elliptic Curve Digital Signature Algorithm (ECDSA).
Let's try to verify a signature (r,s) for a message (z)
given a public key (that is, a point on the secp256k1 curve):


``` ruby
pubkey = PublicKey.new( 0x887387e452b8eacc4acfde10d9aaf7f6d9a0f975aabb10d006e4da568744d06c,
                        0x61de6d95231cd89026e286df3b6ae4a894a3378e393e93a0f45b666329a0ae34 )

# signature 1
z = 0xec208baa0fc1c19f708a9ca96fdeff3ac3f230bb4a7ba4aede4942ad003c0f60
r = 0xac8d1c87e51d0d441be8b3dd5b05c8795b48875dffe00b7ffcfac23010d3a395
s = 0x68342ceff8935ededd102dd876ffd6ba72d6a427a3edb13d26eb0781cb423c4

sig = Signature.new( r, s )
pubkey.verify?( z, sig )     #=> true


# signature 2
z = 0x7c076ff316692a3d7eb3c3bb0f8b1488cf72e1afcd929e29307032997a838a3d
r = 0xeff69ef2b1bd93a66ed5219add4fb51e11a840f404876325a1e8ffe0529a2c
s = 0xc7207fee197d27c618aea621406f6bf5ef6fca38681d82b2f06fddbdce6feab6

sig = Signature.new( r, s )
pubkey.verify?( z, sig )    #=> true
```


And let's sign a message using a private key (that is, a 256-bit integer
of the order (n) of the generation point):

``` ruby
e = 12345                     ## private key - note: do NOT use - only for learning
key = PrivateKey.new( e )

z_hex = Digest::SHA256.hexdigest( 'Programming Elliptic Curve Cryptography!' )
z = z_hex.to_i( 16 )    ## convert 256-bit (32-byte) hexstring to (big) integer number

sig = key.sign( z )
sig.r  #=> 35839919642726191515862186078164267963984698217861116280002507416364797996230
sig.s  #=> 34481949470477153440646085306694123309931748956488082604284303792820502002529


pubkey = key.pubkey       ## derive public key from private
# And let's verify signature using public key
pubkey.verify?( z, sig )  #=> true

# -or-
pubkey = PublicKey.new(
            0xf01d6b9018ab421dd410404cb869072065522bf85734008f105cf385a023a80f,
            0x0eba29d0f0c5408ed681984dc525982abefccd9f7ff01dd26da4999cf3f6a295  )

sig = Signature.new(
        35839919642726191515862186078164267963984698217861116280002507416364797996230,
        34481949470477153440646085306694123309931748956488082604284303792820502002529 )

pubkey.verify?( z, sig )  #=> true
```


That's it.




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
