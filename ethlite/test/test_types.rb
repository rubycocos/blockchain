##
#  to run use
#     ruby -I ./lib -I ./test test/test_types.rb


require 'helper'



class TestTypes < MiniTest::Test

  def test_parse
     t =  Ethlite::Abi::Type.parse( 'uint256' )
     pp t
     puts "  dynamic?: #{t.dynamic?}, size: #{t.size}"
     #=> dynamic?: false, size: 32
     assert_equal 'uint',   t.base
     assert_equal '256',    t.sub     # subtype
     assert_equal [],       t.dims
     assert_equal false,    t.dynamic?

     t =  Ethlite::Abi::Type.parse( 'string' )
     pp t
     puts "  dynamic?: #{t.dynamic?}, size: #{t.size}"
     #=> dynamic?: true, size:
     assert_equal 'string', t.base
     assert_equal '',       t.sub    # subtype
     assert_equal [],       t.dims
     assert_equal true,    t.dynamic?

     t = Ethlite::Abi::Type.parse( '(string,string,bool)' )
     pp t
     puts "  dynamic?: #{t.dynamic?}, size: #{t.size}"
     #=> dynamic?: true, size:
     assert_equal 'tuple',   t.base
     assert_equal ["string", "string", "bool"],  t.types
     assert_equal true,    t.dynamic?     ## because it incl. string
  end


end   # class TestTypes