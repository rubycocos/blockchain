# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_base32_electrologica.rb


require 'helper'


class TestBase32Electrologia < MiniTest::Test


def test_electrologica

  ## Kitty #1001
  ##  see https://cryptokittydex.com/kitties/1001

   binary = 0b0000000000000000010010100101001010010011000111001110010000001000010111000001010010111101110011100000000101001010000000110001100010000100011010100000110010000000100011000110000000101001010010100110001100010100101000110100101000010010100101011011100111001110  # binary
   hex    = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a_1295_b9ce   # hex

   el        = "09-09-09-09-06-07-07-04-01-01-14-01-09-15-14-14-00-05-05-00-06-06-04-04-13-08-06-08-01-03-03-00-05-05-05-06-06-05-05-03-09-08-09-09-11-14-14-14"
   el_fmt    = "09-09-09-09 06-07-07-04 01-01-14-01 09-15-14-14 00-05-05-00 06-06-04-04 13-08-06-08 01-03-03-00 05-05-05-06 06-05-05-03 09-08-09-09 11-14-14-14"
   el_fmt_ii = "09-09-09-09/06-07-07-04/01-01-14-01/09-15-14-14/00-05-05-00/06-06-04-04/13-08-06-08/01-03-03-00/05-05-05-06/06-05-05-03/09-08-09-09/11-14-14-14"

   assert_equal binary, hex


   Base32.format = :electrologica
   el2 = Base32.encode( hex )
   pp el
   pp el2

   assert_equal el, el2
   assert_equal el_fmt,    Base32::Electrologica.fmt( el2 )
   assert_equal el_fmt_ii, Base32::Electrologica.fmt( el2, sep: '/' )

   assert_equal el_fmt,    Base32::Electrologica.fmt( hex, group: 4 )
   assert_equal el_fmt_ii, Base32::Electrologica.fmt( hex, group: 4, sep: '/' )


   hex2 = Base32.decode( el2 )
   pp hex2
   assert_equal hex, hex2

   el3  = Base32::Electrologica.encode( hex )
   hex3 = Base32::Electrologica.decode( el3 )
   assert_equal hex, hex3
   assert_equal el,  el3
end


end  # class TestBase32Electrologia
