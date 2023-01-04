##
#  to run use
#     ruby -I ./lib -I ./test test/test_types.rb


require 'helper'



class TestTypes < MiniTest::Test

  Type   = ABI::Type
  Tuple  = ABI::Tuple
  Parser = ABI::Type::Parser

  ParseError = ABI::Type::ParseError

  def test_parse_dims
    assert_equal [],     Parser._parse_dims( '' )
    assert_equal [-1],   Parser._parse_dims( '[]' )
    assert_equal [-1,3], Parser._parse_dims( '[][3]' )
    assert_equal [2,3],  Parser._parse_dims( '[2][3]' )
  end


  def test_parse_base_type
     assert_equal ['uint', 256, []],  Parser._parse_base_type( 'uint256' )
     assert_equal ['uint', 8, []],    Parser._parse_base_type( 'uint8' )
     assert_equal ['string', nil, []],   Parser._parse_base_type( 'string' )

     assert_equal ['uint', 256, [-1]],    Parser._parse_base_type( 'uint256[]' )
     assert_equal ['uint', 256, [-1,3]],  Parser._parse_base_type( 'uint256[][3]' )
     assert_equal ['string', nil, [-1]],     Parser._parse_base_type( 'string[]' )
  end



  def test_base
     t =  Type.parse( 'uint256' )
     assert_equal 'uint256',  t.format
     pp t

     assert_equal ABI::Uint,  t.class
     assert_equal 256,        t.bits      # subscript of type (size in bits)
     assert_equal false,      t.dynamic?
     assert_equal 32,         t.size

     t =  Type.parse( 'string' )
     assert_equal 'string',  t.format
     pp t

     assert_equal ABI::String, t.class
     assert_equal true,      t.dynamic?
     assert_nil   t.size    ## note: size always  nil if type dynamic
  end


  def test_parse_tuple_type
     assert_equal ['string', 'string', 'bool'],  Parser._parse_tuple_type('string,string,bool')
     assert_equal ['string', '(string,bool)'],   Parser._parse_tuple_type('string,(string,bool)')
     assert_equal ['string', '(string,(string,uint256[]))','address[4]'],
                                 Parser._parse_tuple_type('string,(string,(string,uint256[])),address[4]')
  end


  def test_tuple
     t = Type.parse( '(string,string,bool)' )
     assert_equal '(string,string,bool)',  t.format
     pp t

     assert_equal ABI::Tuple,   t.class
     assert_equal ['string', 'string', 'bool'],  t.types.map {|c| c.format }
     assert_equal true,    t.dynamic?     ## because it incl. string
     assert_nil   t.size    ## note: size always  nil if type dynamic


     t = Type.parse('(string,(string,(string,uint256[])),address[4])' )
     assert_equal '(string,(string,(string,uint256[])),address[4])',  t.format
     pp t

     assert_equal ABI::Tuple,   t.class
     assert_equal ['string', '(string,(string,uint256[]))', 'address[4]'],  t.types.map {|c| c.format }
     assert_equal true,    t.dynamic?     ## because it incl. string
     assert_nil   t.size    ## note: size always nil if type dynamic
  end



####
##  tests initially adapted from
##    https://github.com/cryptape/ruby-ethereum-abi/blob/master/test/abi/type_test.rb


  def test_type_parse
    assert_equal ABI::Uint.new( 8 ), Type.parse("uint8")
    assert_equal ABI::FixedBytes.new( 32 ), Type.parse("bytes32")

    assert_equal ABI::FixedArray.new(
                   ABI::Uint.new( 256 ), 10 ), Type.parse("uint256[10]")

    ## assert_equal Type.new('fixed', [128,128]', [1,2,3,0]), Type.parse("fixed128x128[1][2][3][]")
  end

  def test_type_parse_validations
    assert_raises(ParseError) { Type.parse("string8") }
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
    assert_equal 32, Type.parse("bool").size

    assert_equal 64, Type.parse("uint256[2]").size
    assert_equal 128, Type.parse("address[2][2]").size

    assert_equal 32*2, Type.parse( "bytes3[2]" ).size


    ## assert_equal 32, Type.parse("fixed128x128").size
    ## assert_equal 1024, Type.parse("ufixed192x64[2][2][2][2][2]").size
  end

  def test_subtype_of_array
    t = Type.parse("uint256[2][]")
    puts "uint256[2][]:"
    puts t.format
    pp t
    ##
    #<ABI::Array @subtype=
    #  <ABI::FixedArray @dim=2, @subtype=
    #    <ABI::Uint @bits=256>>>
    assert_equal 2, t.subtype.dim
    assert_equal ABI::Array, t.class               ## note: outer most returns first
    assert_equal ABI::FixedArray, t.subtype.class  ## note: inner most returned last!!
    assert_equal ABI::Uint, t.subtype.subtype.class

    t = Type.parse("uint256[2][3]")
    puts "uint256[2][3]:"
    puts t.format
    pp t
    assert_equal 3, t.dim           ## note: outer most returns first
    assert_equal 2, t.subtype.dim   ## note: inner most returned last!!
    assert_equal ABI::FixedArray, t.class
    assert_equal ABI::FixedArray, t.subtype.class
    assert_equal ABI::Uint, t.subtype.subtype.class
 end



end   # class TestTypes