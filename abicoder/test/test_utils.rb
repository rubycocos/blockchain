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

BYTE_ZERO  = "\x00".b.freeze
BYTE_ONE   = "\x01".b.freeze


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

bin = BYTE_ZERO * 32
pp bin
puts bin.encoding
puts bin.frozen?

bin = [BYTE_ZERO,BYTE_ZERO,BYTE_ZERO,BYTE_ZERO].join
pp bin
puts bin.encoding
puts bin.frozen?





class TestUtils < MiniTest::Test


  def assert_bin( exp, bin )   ## note: always check for BINARY encoding too
    assert bin.encoding == Encoding::BINARY
    assert_equal exp, bin
  end


  def test_lpad
     assert_equal  "hello", "hello".ljust( 4, BYTE_ZERO, )
     assert_equal  "hello", lpad( "hello", 4, BYTE_ZERO )

     assert_equal  "hello".rjust( 20, BYTE_ZERO ),
                   lpad( "hello", 20, BYTE_ZERO )
  end


  def test_lpad32_int
    bin = ABI.encoder.lpad_int( 0 )
    pp bin
    assert_bin BYTE_ZERO*32, bin

    bin = ABI.encoder.lpad_int( 1 )
    pp bin
    assert_bin BYTE_ZERO*31+BYTE_ONE, bin
  end

  def test_lpad32_hex
     bin = ABI.encoder.lpad_hex( '00' )
     pp bin
     assert_bin BYTE_ZERO*32, bin

     bin = ABI.encoder.lpad_hex( '01' )
     pp bin
     assert_bin BYTE_ZERO*31+BYTE_ONE, bin

     bin = ABI.encoder.lpad_hex( 'FF'*32 )
     pp bin
     assert_bin "\xFF".b*32, bin
  end


  def test_lpad32
    bin = ABI.encoder.lpad( BYTE_ZERO )
    pp bin
    assert_bin BYTE_ZERO*32, bin

    bin = ABI.encoder.lpad( BYTE_ONE )
    pp bin
    assert_bin BYTE_ZERO*31+BYTE_ONE, bin

    bin = ABI.encoder.lpad( "\0xff".b*33 )
    pp bin
    assert_bin "\0xff".b*33, bin
  end

  def test_rpad32
    bin = ABI.encoder.rpad( BYTE_ZERO )
    pp bin
    assert_bin BYTE_ZERO*32, bin

    bin = ABI.encoder.rpad( BYTE_ONE )
    pp bin
    assert_bin BYTE_ONE+BYTE_ZERO*31, bin

    bin = ABI.encoder.rpad( "\0xff".b*33 )
    pp bin
    assert_bin "\0xff".b*33, bin
  end
end   # class TestUtils