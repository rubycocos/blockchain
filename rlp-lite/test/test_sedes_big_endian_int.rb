##
#  to run use
#     ruby -I ./lib -I ./test test/test_sedes_big_endian_int.rb


require 'helper'


class TestRlp < MiniTest::Test

  INTEGERS =
    [
      256,
      257,
      4839,
      849302,
      483290432,
      483290483290482039482039,
      48930248348219540325894323584235894327865439258743754893066,
    ]

  NEGATIVES =
     [-1, -100, -255, -256, -2342423]


  def test_unsigned_integers

    assert INTEGERS[-1] < 2 ** 256

    INTEGERS.each do |u|
      serial = Rlp::Sedes.big_endian_int.serialize u
      deserial = Rlp::Sedes.big_endian_int.deserialize serial

      assert_equal      deserial, u
      assert  serial[0] != "\x00"    unless u == 0
    end
  end

  def test_negative_integers
    NEGATIVES.each do |n|
      assert_raises( Rlp::SerializationError, "Cannot serialize negative integers")  {
         Rlp::Sedes.big_endian_int.serialize n
      }
    end
  end

  def test_single_bytes
    (1...256).each do |b|
      c = b.chr
      serial = Rlp::Sedes.big_endian_int.serialize b
      assert_equal  serial,  c

      deserial = Rlp::Sedes.big_endian_int.deserialize serial
      assert_equal deserial, b
    end
  end

  def test_valid_data
    [
      [256, "\x01\x00".b],
      [1024, "\x04\x00".b],
      [65535, "\xFF\xFF".b],
    ].each do |(n, s)|
      serial = Rlp::Sedes.big_endian_int.serialize n
      deserial = Rlp::Sedes.big_endian_int.deserialize serial

      assert_equal serial, s
      assert_equal deserial, n
    end
  end


  def test_fixed_length
    s = Rlp::Sedes::BigEndianInt.new 4
    [0,
     1,
     255,
     256,
     256 ** 3,
     256 ** 4 - 1].each do |i|
      assert_equal s.serialize(i).length, 4
      assert_equal s.deserialize(s.serialize i), i
    end

    [256 ** 4,
     256 ** 4 + 1,
     256 ** 5,
     (-1 - 256),
     "asdf"].each do |i|
      assert_raises( Rlp::SerializationError ) {
        s.serialize(i)
      }
    end

    t = Rlp::Sedes::BigEndianInt.new 2
    assert_raises( Rlp::SerializationError, "Integer too large (does not fit in 2 bytes)" ) {
       t.serialize 256 ** 4
    }
  end


end   # class TestRlp

