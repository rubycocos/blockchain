##
#  to run use
#     ruby -I ./lib -I ./test test/test_sedes_binary.rb





require 'helper'


class TestRlp < MiniTest::Test

 def test_fixed_length_binary
    b = Rlp::Sedes::Binary.fixed_length( 3 )

    assert_equal "foo", b.serialize( "foo" )
    assert_equal "bar", b.deserialize( "bar" )

    assert_raises( Rlp::SerializationError, "Object has invalid length" ) {
       b.serialize "foobar"
    }
    assert_raises( Rlp::DeserializationError, "String has invalid length" ) {
      b.deserialize "foobar"
    }
 end

end

