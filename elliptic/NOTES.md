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



## More Elipictic libraries

ruby

- <https://github.com/starkbank/ecdsa-ruby>
- <https://github.com/DavidEGrayson/ruby_ecdsa>
- <https://github.com/cedarcode/openssl-signature_algorithm>


