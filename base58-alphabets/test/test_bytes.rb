# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_bytes.rb


require 'helper'


class TestBytes < MiniTest::Test


def test_bytes
   bytes = Base58._bytes( 123456789 )
   ## pp bytes

   assert_equal [10,52,43,23,19], bytes

   assert_equal 123456789, Base58._pack( bytes )


   assert_equal 123456789, Base58._pack( Base58._bytes( 123456789 ))
end

end  # class TestBytes
