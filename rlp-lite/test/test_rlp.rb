##
#  to run use
#     ruby -I ./lib -I ./test test/test_rlp.rb


require 'helper'

require 'json'


class TestRlp < MiniTest::Test

  RLP_TEST = JSON.parse( File.read( './test/data/rlptest.json', encoding: 'ascii-8bit' ))
  pp RLP_TEST

  def test_encode
    RLP_TEST.each do |test|
      object = test.last['in']

      # big integers defined as '#' will be treated as numbers
      object = object.delete('#').to_i  if object.is_a?( String ) and object.include?( '#' )

      # we compare the hex output without prefix in down case
      expected_rlp = Rlp::Util.remove_hex_prefix( test.last['out'].downcase )
      encoded = Rlp.encode( object )

      assert_equal expected_rlp, Rlp::Util.bin_to_hex( encoded )
      assert_equal Rlp::Util.hex_to_bin( expected_rlp ), encoded
    end
  end

  def test_decode
      RLP_TEST.each do |test|
      expected = test.last['in']

      # big integers defined as '#' will be treated as numbers
      expected = expected.delete('#').to_i   if expected.is_a?( String ) and expected.include?( '#' )

      # we compare the hex output without prefix in down case
      rlp = Rlp::Util.remove_hex_prefix test.last['out'].downcase
      decoded = Rlp.decode( rlp )

      # we have to work with assumptions here, if the input is to be expected
      # a numeric, we also deserialize it for test-convenience
      decoded = Rlp::Util.deserialize_big_endian_to_int( decoded ) if expected.is_a?( Numeric )

      # another very specific assumption: for the multilist test case,
      # we need to specifically deserialize the entire list first
      multilist = Rlp::Sedes::List.new( elements: [Rlp::Sedes.binary,
                                                   [Rlp::Sedes.big_endian_int],
                                                   Rlp::Sedes.big_endian_int])
      decoded = multilist.deserialize( decoded )    if test.first == 'multilist'

      assert_equal expected, decoded
    end
  end




end   # class TestRlp


