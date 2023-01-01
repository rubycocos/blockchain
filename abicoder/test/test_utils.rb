##
#  to run use
#     ruby -I ./lib -I ./test test/test_utils.rb


####
# replace "hand-coded" string helpers (lpad, zpad, etc.)
#   with builtin string methods (ljust, etc.)
#
#
# note:  ljust == rpad !!
#    and  rjust == lpad



require 'helper'


BYTE_ZERO = "\x00".b

def lpad(x, l, symbol )
  return x if x.size >= l
  symbol * (l - x.size) + x
end

pp "hello".ljust(4, BYTE_ZERO )
#=> "hello"
pp "hello".ljust(20, BYTE_ZERO )
#=> "hello\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000"

pp "hello".rjust(4, BYTE_ZERO )
#=> "hello"
pp "hello".rjust(20, BYTE_ZERO )
#=> "\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000hello"


class TestUtils < MiniTest::Test

  def test_lpad
     assert_equal  "hello", "hello".ljust( 4, BYTE_ZERO, )
     assert_equal  "hello", lpad( "hello", 4, BYTE_ZERO )

     assert_equal  "hello".rjust( 20, BYTE_ZERO ),
                   lpad( "hello", 20, BYTE_ZERO )
  end

end