##
#  to run use
#     ruby -I ./lib -I ./test test/test_types.rb


require 'helper'



class TestTypes < MiniTest::Test

  def test_parse_base_type
     assert_equal ['uint', '256', []],  ABI::Type._parse_base_type( 'uint256' )
     assert_equal ['uint', '8', []],    ABI::Type._parse_base_type( 'uint8' )
     assert_equal ['string', '', []],   ABI::Type._parse_base_type( 'string' )

     assert_equal ['uint', '256', [0]],    ABI::Type._parse_base_type( 'uint256[]' )
     assert_equal ['uint', '256', [0,3]],  ABI::Type._parse_base_type( 'uint256[][3]' )
     assert_equal ['string', '', [0]],     ABI::Type._parse_base_type( 'string[]' )
  end



  def test_base
     t =  ABI::Type.parse( 'uint256' )
     assert_equal 'uint256',  t.format
     pp t

     assert_equal 'uint',     t.base
     assert_equal '256',      t.sub     # subtype
     assert_equal [],         t.dims
     assert_equal false,      t.dynamic?
     assert_equal 32,         t.size

     t =  ABI::Type.parse( 'string' )
     assert_equal 'string',  t.format
     pp t

     assert_equal 'string', t.base
     assert_equal '',       t.sub    # subtype
     assert_equal [],       t.dims
     assert_equal true,    t.dynamic?
     assert_nil   t.size    ## note: size always  nil if type dynamic
  end


  def test_parse_tuple_type
     assert_equal ['string', 'string', 'bool'],  ABI::Tuple._parse_tuple_type('string,string,bool')
     assert_equal ['string', '(string,bool)'],   ABI::Tuple._parse_tuple_type('string,(string,bool)')
     assert_equal ['string', '(string,(string,uint256[]))','address[4]'],
                    ABI::Tuple._parse_tuple_type('string,(string,(string,uint256[])),address[4]')
  end


  def test_tuple
     t = ABI::Type.parse( '(string,string,bool)' )
     assert_equal '(string,string,bool)',  t.format
     pp t

     assert_equal 'tuple',   t.base
     assert_equal ['string', 'string', 'bool'],  t.types.map {|c| c.format }
     assert_equal true,    t.dynamic?     ## because it incl. string
     assert_nil   t.size    ## note: size always  nil if type dynamic


     t = ABI::Type.parse('(string,(string,(string,uint256[])),address[4])' )
     assert_equal '(string,(string,(string,uint256[])),address[4])',  t.format
     pp t

     assert_equal 'tuple',   t.base
     assert_equal ['string', '(string,(string,uint256[]))', 'address[4]'],  t.types.map {|c| c.format }
     assert_equal true,    t.dynamic?     ## because it incl. string
     assert_nil   t.size    ## note: size always nil if type dynamic
  end


end   # class TestTypes