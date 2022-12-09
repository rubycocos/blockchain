##
#  to run use
#     ruby -I ./lib -I ./test test/test_sedes.rb


require 'helper'



class TestRlp < MiniTest::Test

  PAIRS =
    [
      [5,  Rlp::Sedes.big_endian_int],
      [0,  Rlp::Sedes.big_endian_int],
      [-1, nil],
      ["", Rlp::Sedes.binary],
      ["asdf", Rlp::Sedes.binary],
      ['\xe4\xf6\xfc\xea\xe2\xfb', Rlp::Sedes.binary],
      [[], Rlp::Sedes::List.new],
      [[1, 2, 3], Rlp::Sedes::List.new(elements: [Rlp::Sedes.big_endian_int,
                                                  Rlp::Sedes.big_endian_int,
                                                  Rlp::Sedes.big_endian_int])],
      [[[], "asdf"], Rlp::Sedes::List.new(elements: [[], Rlp::Sedes.binary])],
    ]


  def test_infer
    PAIRS.each do |obj, sedes|
      if sedes.nil?
        assert_raises( TypeError ) {
          Rlp::Sedes.infer( obj )
        }
      else
        inferred = Rlp::Sedes.infer( obj )
        assert_equal sedes, inferred
      end
    end
  end

end

