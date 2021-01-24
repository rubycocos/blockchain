# Notes


## OpenSSL (binding/wrapper) in ruby

- <https://github.com/ruby/openssl>
- <https://ruby-doc.org/stdlib-2.5.1/libdoc/openssl/rdoc/OpenSSL.html>



*Tips & Tricks*


big number (bn)

- opensll adds `Integer#to_bn` for easy conversion

``` ruby
999.to_bn    # same as   OpenSSL::BN.new( 999 )
-999.to_bn
2**107-1).to_bn
(-(2**107-1)).to_bn
```

Source: <https://github.com/ruby/openssl/blob/master/test/openssl/test_bn.rb>

use to_bn to construct Point too? why? why not?

``` ruby
assert_equal 0x040603.to_bn, point.to_bn
assert_equal 0x040603.to_bn, point.to_bn(:uncompressed)
assert_equal 0x0306.to_bn,   point.to_bn(:compressed)
```

Source: <https://github.com/ruby/openssl/blob/master/test/openssl/test_pkey_ec.rb>


## More Elliptic Libraries

ruby

- <https://github.com/starkbank/ecdsa-ruby>
- <https://github.com/DavidEGrayson/ruby_ecdsa>
- <https://github.com/cedarcode/openssl-signature_algorithm>

python

- <https://github.com/alexmgr/tinyec>




## More Elliptic Articles

A (relatively easy to understand) primer on elliptic curve cryptography
Everything you wanted to know about the next generation of public key crypto
by  Nick Sullivan, October 2013

- <https://arstechnica.com/information-technology/2013/10/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/>

Elliptic Curve Cryptography: a gentle introduction
by Andrea Corbellini, May 2015

- <https://andrea.corbellini.name/2015/05/17/elliptic-curve-cryptography-a-gentle-introduction/>

What is the math behind elliptic curve cryptography?
by Hans Knutson, April 2018

- <https://hackernoon.com/what-is-the-math-behind-elliptic-curve-cryptography-f61b25253da3>


Elliptic Curve @ Wolfram Math World
- <https://mathworld.wolfram.com/EllipticCurve.html>



Practical Cryptography for Developers by Svetlin Nakov

Elliptic Curve Cryptography (ECC)
- <https://cryptobook.nakov.com/asymmetric-key-ciphers/elliptic-curve-cryptography-ecc>

ECDSA: Elliptic Curve Signatures 
- <https://cryptobook.nakov.com/digital-signatures/ecdsa-sign-verify-messages>

sources: <https://github.com/nakov/practical-cryptography-for-developers-book>



Wikipedia:
-  Elliptic curve - <https://en.wikipedia.org/wiki/Elliptic_curve>
-  Elliptic Curve Cryptography (ECC)  - <https://en.wikipedia.org/wiki/Elliptic-curve_cryptography>
-  Elliptic Curve Digital Signature Algorithm (ECDSA) - <https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm>
-  Elliptic curve point multiplication - <https://en.wikipedia.org/wiki/Elliptic_curve_point_multiplication>
