##
#  to run use
#     ruby -I ./lib -I ./test test/test_sedes_list.rb


require 'helper'


class TestRlp < MiniTest::Test

  L1 =  Rlp::Sedes::List.new
  L2 =  Rlp::Sedes::List.new elements: [Rlp::Sedes.big_endian_int,
                                        Rlp::Sedes.big_endian_int]
  L3 =   Rlp::Sedes::List.new elements: [L1,
                                         L2,
                                         [[[]]]]


  def test_valid
    assert_equal [], L1.deserialize( [] )
    assert_equal [137, 374], L2.deserialize( ["\x89", "\x01v"] )
    assert_equal [[],
                  [137, 374],
                  [[[]]]],
                L3.deserialize( [[],
                                ["\x89", "\x01v"],
                                [[[]]]] )
  end

  def test_invalid_length_or_type

    assert_raises( Rlp::SerializationError, "List has wrong length" ) {
      L1.serialize( [[]] )
    }

    assert_raises( Rlp::SerializationError, "List has wrong length" ) {
      L1.serialize( [5] )
    }

    [[],
     [1, 2, 3],
     [1, [2, 3], 4]
    ].each do |d|
      assert_raises( Rlp::SerializationError, "List has wrong length" ) {
        L2.serialize(d)
      }
    end

    [[],
     [[], [], [[[]]]],
     [[], [5, 6], [[]]]
    ].each do |d|
      assert_raises( Rlp::SerializationError ) {
        L3.serialize(d)
      }
    end
  end

end

