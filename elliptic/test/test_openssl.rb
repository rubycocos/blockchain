###
#  to run use
#     ruby -I ./lib -I ./test test/test_openssl.rb


require 'helper'


## test some "basic" openssl (binding) machinery
##  for source, see https://github.com/ruby/openssl

class TestOpenssl < MiniTest::Test

def test_version
  puts "OPENSSL_VERSION: #{OpenSSL::OPENSSL_VERSION}"
  puts "OPENSSL_LIBRARY_VERSION: #{OpenSSL::OPENSSL_LIBRARY_VERSION}"
end


def test_bn
  [999,
   -999,
   2**107-1,
  -(2**107-1)].each do |num|
     assert_equal OpenSSL::BN.new( num ), num.to_bn
  end
end

def test_bn_to_hex
  [
    [999,  "03E7"],
    [-999, "-03E7"],
    [2**107-1, "07FFFFFFFFFFFFFFFFFFFFFFFFFF"],
    [-(2**107-1), "-07FFFFFFFFFFFFFFFFFFFFFFFFFF"]
  ].each do |item|
     assert_equal item[1], item[0].to_bn.to_s(16)
  end
end

end # class TestOpenssl
