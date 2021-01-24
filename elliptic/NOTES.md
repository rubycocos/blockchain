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

Source: https://github.com/ruby/openssl/blob/master/test/openssl/test_bn.rb







## More Elipictic libraries

ruby

- <https://github.com/starkbank/ecdsa-ruby>
- <https://github.com/DavidEGrayson/ruby_ecdsa>
- <https://github.com/cedarcode/openssl-signature_algorithm>


