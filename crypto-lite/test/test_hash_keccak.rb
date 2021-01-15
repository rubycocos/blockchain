###
#  to run use
#     ruby -I ./lib -I ./test test/test_hash_keccak.rb


require 'helper'


class TestHashKeccak < MiniTest::Test

  KECCAK256_EMPTY         = 'c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470'
  KECCAK256_TESTING       = '5f16f4c7f149ac4f9510d9cf8cf384038ad348b3bcdc01915f95de12df9d1b02'
  KECCAK256_HELLO_CRYPTOS = '2cf14baa817e931f5cc2dcb63c889619d6b7ae0794fc2223ebadf8e672c776f5'


def test_empty
   assert_equal KECCAK256_EMPTY, keccak256( '' )
end

def test_misc
   assert_equal KECCAK256_TESTING,       keccak256( 'testing' )
   assert_equal KECCAK256_HELLO_CRYPTOS, keccak256( 'Hello, Cryptos!' )
end

end # class TestHashKeccak
