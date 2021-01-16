# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_base32_kai.rb


require 'helper'


class TestBase32Kai < MiniTest::Test


def test_kai

  ## Kitty #1001
  ##  see https://cryptokittydex.com/kitties/1001

   binary = 0b0000000000000000010010100101001010010011000111001110010000001000010111000001010010111101110011100000000101001010000000110001100010000100011010100000110010000000100011000110000000101001010010100110001100010100101000110100101000010010100101011011100111001110  # binary
   hex    = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a_1295_b9ce   # hex

   kai_fmt    = "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"
   kai_fmt_ii = "aaaa/7885/22f2/agff/1661/7755/e979/2441/6667/7664/a9aa/cfff"
   kai_fmt8   = "aaaa7885 22f2agff 16617755 e9792441 66677664 a9aacfff"
   kai     = kai_fmt.gsub( ' ', '' )

   assert_equal binary, hex

   puts "binary number:"
   pp binary
   puts "hex number:"
   pp hex

   Base32.format = :kai
   kai2  = Base32.encode( hex )
   pp kai
   pp kai2

   assert_equal kai, kai2
   assert_equal kai_fmt,    Base32::Kai.fmt( kai2 )
   assert_equal kai_fmt_ii, Base32::Kai.fmt( kai2, sep: '/' )
   assert_equal kai_fmt8,   Base32::Kai.fmt( kai2, group: 8 )

   assert_equal kai_fmt,    Base32::Kai.fmt( hex, group: 4 )
   assert_equal kai_fmt_ii, Base32::Kai.fmt( hex, group: 4, sep: '/' )
   assert_equal kai_fmt8,   Base32::Kai.fmt( hex, group: 8 )


   hex2 = Base32.decode( kai2 )
   pp hex2
   assert_equal hex, hex2

   kai3  = Base32::Kai.encode( hex )
   hex3  = Base32::Kai.decode( kai3 )
   assert_equal hex,   hex3
   assert_equal kai,   kai3


   puts "kai.length: #{kai.length}"  ## 48
   puts "  first: #{kai[0]}"
   puts "  last:  #{kai[-1]}"
   puts "  last:  #{kai[47]}"

   puts kai.reverse
   puts kai.reverse[0,4]
   puts kai.reverse[4,4]
   puts kai.reverse[8,4]
   eyes = kai.reverse[12,4]
   puts "eyes:"
   puts eyes

   color1 = kai.reverse[16,4]
   puts "color1:"
   puts color1
   pp    color1[0]
end


end  # class TestBase32
