##
#  to run use
#     ruby -I ./lib -I ./test test/test_encoding.rb


require 'helper'


class TestEncoding < MiniTest::Test

BYTE_ZERO  = "\x00".b.freeze
BYTE_ONE   = "\x01".b.freeze


def assert_bin( exp, bin )   ## note: always check for BINARY encoding too
  assert bin.encoding == Encoding::BINARY
  assert_equal exp, bin
end


def test_lpad
  bin = ABI.encoder.lpad_int( 0 )
  pp bin
  assert_bin BYTE_ZERO*32, bin

  bin = ABI.encoder.lpad_int( 1 )
  pp bin
  assert_bin BYTE_ZERO*31+BYTE_ONE, bin
end

def test_lpad_hex
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


def test_lpad
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

def test_rpad
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


end   # class TestEncoding

