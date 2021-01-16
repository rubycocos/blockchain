# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_bytes.rb


require 'helper'


class TestBytes < MiniTest::Test


def hex
  ## Kitty #1001
  ##  see https://cryptokittydex.com/kitties/1001
  0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a_1295_b9ce   # hex
end

def bytes
  [9,9,9,9,6,7,7,4,1,1,14,1,9,15,14,14,0,5,5,0,6,6,4,4,13,8,6,8,1,3,3,0,5,5,5,6,6,5,5,3,9,8,9,9,11,14,14,14]
end


def test_bytes_kai
   kai_fmt    = "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"
   kai_fmt2   = "AAAA 7885 22F2 AGFF 1661 7755 E979 2441 6667 7664 A9AA CFFF"
   kai     = kai_fmt.gsub( ' ', '' )

   Base32.format = :kai

   pp bytes2  = Base32._bytes( hex )
   pp bytes3  = Base32.bytes( hex )
   pp bytes4  = Base32.bytes( kai )
   pp bytes5  = Base32.bytes( kai_fmt )
   pp bytes6  = Base32.bytes( kai_fmt2 )

   pp bytes7  = Base32::Kai.bytes( hex )
   pp bytes8  = Base32::Kai.bytes( kai )
   pp bytes9  = Base32::Kai.bytes( kai_fmt )
   pp bytes10 = Base32::Kai.bytes( kai_fmt2 )

   assert_equal 48,    bytes.size
   assert_equal bytes, bytes2
   assert_equal bytes, bytes3
   assert_equal bytes, bytes4
   assert_equal bytes, bytes5
   assert_equal bytes, bytes6
   assert_equal bytes, bytes7
   assert_equal bytes, bytes8
   assert_equal bytes, bytes9
   assert_equal bytes, bytes10

   ## try encode bytes
   assert_equal kai,     Base32.encode( bytes )
   assert_equal kai_fmt, Base32.fmt( bytes )

   assert_equal kai,     Base32::Kai.encode( bytes )
   assert_equal kai_fmt, Base32::Kai.fmt( bytes )

   ## try decode/pack bytes
   hex = Base32::Kai.decode( kai )
   assert_equal hex,                  Base32._pack( bytes )
   assert_equal Base32._bytes( hex ), Base32._bytes( Base32._pack( bytes ))
   assert_equal bytes,                Base32._bytes( hex )

   assert_equal hex, Base32.decode( bytes )
   assert_equal hex, Base32::Kai.decode( bytes )
end


def test_bytes_crockford
   crockford_fmt =  "9999 6774 11e1 9fee 0550 6644 d868 1330 5556 6553 9899 beee"
   crockford_fmt2 = "9999 6774 11E1 9FEE 0550 6644 D868 1330 5556 6553 9899 BEEE"
   crockford     = crockford_fmt.gsub( ' ', '' )

   Base32.format = :crockford

   pp bytes2  = Base32._bytes( hex )
   pp bytes3  = Base32.bytes( hex )
   pp bytes4  = Base32.bytes( crockford )
   pp bytes5  = Base32.bytes( crockford_fmt )
   pp bytes6  = Base32.bytes( crockford_fmt2 )

   pp bytes7  = Base32::Crockford.bytes( hex )
   pp bytes8  = Base32::Crockford.bytes( crockford )
   pp bytes9  = Base32::Crockford.bytes( crockford_fmt )
   pp bytes10 = Base32::Crockford.bytes( crockford_fmt2 )

   assert_equal 48,    bytes.size
   assert_equal bytes, bytes2
   assert_equal bytes, bytes3
   assert_equal bytes, bytes4
   assert_equal bytes, bytes5
   assert_equal bytes, bytes6
   assert_equal bytes, bytes7
   assert_equal bytes, bytes8
   assert_equal bytes, bytes9
   assert_equal bytes, bytes10

   ## try encode bytes
   assert_equal crockford,     Base32.encode( bytes )
   assert_equal crockford_fmt, Base32.fmt( bytes )

   assert_equal crockford,     Base32::Crockford.encode( bytes )
   assert_equal crockford_fmt, Base32::Crockford.fmt( bytes )

   ## try decode/pack bytes
   hex = Base32::Crockford.decode( crockford )
   assert_equal hex,                  Base32._pack( bytes )
   assert_equal Base32._bytes( hex ), Base32._bytes( Base32._pack( bytes ))
   assert_equal bytes,                Base32._bytes( hex )

   assert_equal hex, Base32.decode( bytes )
   assert_equal hex, Base32::Crockford.decode( bytes )
end


def test_bytes_electrologica
   el_fmt = "09-09-09-09 06-07-07-04 01-01-14-01 09-15-14-14 00-05-05-00 06-06-04-04 13-08-06-08 01-03-03-00 05-05-05-06 06-05-05-03 09-08-09-09 11-14-14-14"
   el     = "09-09-09-09-06-07-07-04-01-01-14-01-09-15-14-14-00-05-05-00-06-06-04-04-13-08-06-08-01-03-03-00-05-05-05-06-06-05-05-03-09-08-09-09-11-14-14-14"

   Base32.format = :electrologica

   pp bytes2  = Base32._bytes( hex )
   pp bytes3  = Base32.bytes( hex )
   pp bytes4  = Base32.bytes( el )
   pp bytes5  = Base32.bytes( el_fmt )

   pp bytes6  = Base32::Electrologica.bytes( hex )
   pp bytes7  = Base32::Electrologica.bytes( el )
   pp bytes8  = Base32::Electrologica.bytes( el_fmt )

   assert_equal 48,    bytes.size
   assert_equal bytes, bytes2
   assert_equal bytes, bytes3
   assert_equal bytes, bytes4
   assert_equal bytes, bytes5
   assert_equal bytes, bytes6
   assert_equal bytes, bytes7
   assert_equal bytes, bytes8

   ## try encode bytes
   assert_equal el,     Base32.encode( bytes )
   assert_equal el_fmt, Base32.fmt( bytes )

   assert_equal el,     Base32::Electrologica.encode( bytes )
   assert_equal el_fmt, Base32::Electrologica.fmt( bytes )

   ## try decode/pack bytes
   hex = Base32::Electrologica.decode( el )
   assert_equal hex,                  Base32._pack( bytes )
   assert_equal Base32._bytes( hex ), Base32._bytes( Base32._pack( bytes ))
   assert_equal bytes,                Base32._bytes( hex )

   assert_equal hex, Base32.decode( bytes )
   assert_equal hex, Base32::Electrologica.decode( bytes )
end

end  # class TestBytes
