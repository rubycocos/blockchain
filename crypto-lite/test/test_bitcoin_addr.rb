###
#  to run use
#     ruby -I ./lib -I ./test test/test_bitcoin_addr.rb


require 'helper'

class TestBitcoinAddr < MiniTest::Test


def test_bitcoin_addr_v1
   pk = "0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352"

   step1 = Crypto.sha256( hex: pk ).hexdigest
   assert_equal "0b7c28c9b7290c98d7438e70b3d3f7c848fbd7d1dc194ff83f4f7cc9b1378e98",
                step1

   step2 = Crypto.ripemd160( hex: step1 ).hexdigest
   assert_equal "f54a5851e9372b87810a8e60cdd2e7cfd80b6e31",
                step2

   step3 = "00" + step2
   assert_equal "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31",
                step3

   step4 = Crypto.sha256( hex: step3 ).hexdigest
   assert_equal "ad3c854da227c7e99c4abfad4ea41d71311160df2e415e713318c70d67c6b41c",
                step4

   step5 = Crypto.sha256( hex: step4 ).hexdigest
   assert_equal "c7f18fe8fcbed6396741e58ad259b5cb16b7fd7f041904147ba1dcffabf747fd",
                 step5

   step6 = step5[0..7]      # note: 4 bytes in hex string are 8 digits/chars
   assert_equal "c7f18fe8", step6

   step7 = step3 + step6
   assert_equal "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31c7f18fe8", step7

   addr  = Crypto.base58( hex: step7 )
   assert_equal "1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs", addr
end


def test_bitcoin_addr_v2
   pk = "0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352"

   step1 = Crypto.hash160( hex: pk ).hexdigest
   assert_equal "f54a5851e9372b87810a8e60cdd2e7cfd80b6e31", step1

   step2 = "00" + step1
   assert_equal "00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31", step2

   addr  = Crypto.base58check( hex: step2 )
   assert_equal "1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs", addr
end

end # class TestBitcoinAddr
