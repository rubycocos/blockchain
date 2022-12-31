##
#  to run use
#     ruby -I ./lib -I ./test test/test_types.rb


require 'helper'



class TestTypes < MiniTest::Test

  Type  = ABI::Type
  Tuple = ABI::Tuple

  ParseError = ABI::Type::ParseError


  def test_parse_base_type
     assert_equal ['uint', '256', []],  Type._parse_base_type( 'uint256' )
     assert_equal ['uint', '8', []],    Type._parse_base_type( 'uint8' )
     assert_equal ['string', '', []],   Type._parse_base_type( 'string' )

     assert_equal ['uint', '256', [0]],    Type._parse_base_type( 'uint256[]' )
     assert_equal ['uint', '256', [0,3]],  Type._parse_base_type( 'uint256[][3]' )
     assert_equal ['string', '', [0]],     Type._parse_base_type( 'string[]' )
  end



  def test_base
     t =  Type.parse( 'uint256' )
     assert_equal 'uint256',  t.format
     pp t

     assert_equal 'uint',     t.base
     assert_equal '256',      t.sub     # subtype
     assert_equal [],         t.dims
     assert_equal false,      t.dynamic?
     assert_equal 32,         t.size

     t =  Type.parse( 'string' )
     assert_equal 'string',  t.format
     pp t

     assert_equal 'string', t.base
     assert_equal '',       t.sub    # subtype
     assert_equal [],       t.dims
     assert_equal true,    t.dynamic?
     assert_nil   t.size    ## note: size always  nil if type dynamic
  end


  def test_parse_tuple_type
     assert_equal ['string', 'string', 'bool'],  Tuple._parse_tuple_type('string,string,bool')
     assert_equal ['string', '(string,bool)'],   Tuple._parse_tuple_type('string,(string,bool)')
     assert_equal ['string', '(string,(string,uint256[]))','address[4]'],
                    Tuple._parse_tuple_type('string,(string,(string,uint256[])),address[4]')
  end


  def test_tuple
     t = Type.parse( '(string,string,bool)' )
     assert_equal '(string,string,bool)',  t.format
     pp t

     assert_equal 'tuple',   t.base
     assert_equal ['string', 'string', 'bool'],  t.types.map {|c| c.format }
     assert_equal true,    t.dynamic?     ## because it incl. string
     assert_nil   t.size    ## note: size always  nil if type dynamic


     t = Type.parse('(string,(string,(string,uint256[])),address[4])' )
     assert_equal '(string,(string,(string,uint256[])),address[4])',  t.format
     pp t

     assert_equal 'tuple',   t.base
     assert_equal ['string', '(string,(string,uint256[]))', 'address[4]'],  t.types.map {|c| c.format }
     assert_equal true,    t.dynamic?     ## because it incl. string
     assert_nil   t.size    ## note: size always nil if type dynamic
  end



####
##  tests initially adapted from
##    https://github.com/cryptape/ruby-ethereum-abi/blob/master/test/abi/type_test.rb


  def test_type_parse
    assert_equal Type.new('uint',  '8', []),              Type.parse("uint8")
    assert_equal Type.new('bytes', '32', []),             Type.parse("bytes32")
    assert_equal Type.new('uint',  '256',     [10]),      Type.parse("uint256[10]")
    ## assert_equal Type.new('fixed', '128x128', [1,2,3,0]), Type.parse("fixed128x128[1][2][3][]")
  end

  def test_type_parse_validations
    ## assert_raises(ParseError) { Type.parse("string8") }
    assert_raises(ParseError) { Type.parse("bytes33") }
    assert_raises(ParseError) { Type.parse('hash')}
    assert_raises(ParseError) { Type.parse('address8') }
    assert_raises(ParseError) { Type.parse('bool8') }
    assert_raises(ParseError) { Type.parse('decimal') }

    assert_raises(ParseError) { Type.parse("int") }
    assert_raises(ParseError) { Type.parse("int2") }
    assert_raises(ParseError) { Type.parse("int20") }
    assert_raises(ParseError) { Type.parse("int512") }

    assert_raises(ParseError) { Type.parse("fixed") }
    assert_raises(ParseError) { Type.parse("fixed256") }
    assert_raises(ParseError) { Type.parse("fixed2x2") }
    assert_raises(ParseError) { Type.parse("fixed20x20") }
    assert_raises(ParseError) { Type.parse("fixed256x256") }
  end


  def test_type_size
    assert_nil Type.parse("string").size
    assert_nil Type.parse("bytes").size
    assert_nil Type.parse("uint256[]").size
    assert_nil Type.parse("uint256[4][]").size

    assert_equal 32, Type.parse("uint256").size
    ## assert_equal 32, Type.parse("fixed128x128").size
    assert_equal 32, Type.parse("bool").size

    assert_equal 64, Type.parse("uint256[2]").size
    assert_equal 128, Type.parse("address[2][2]").size
    ## assert_equal 1024, Type.parse("ufixed192x64[2][2][2][2][2]").size
  end

  def test_subtype_of_array
    assert_equal [], Type.parse("uint256").subtype.dims
    assert_equal [2], Type.parse("uint256[2][]").subtype.dims
    assert_equal [2], Type.parse("uint256[2][2]").subtype.dims
  end



end   # class TestTypes