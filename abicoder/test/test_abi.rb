##
#  to run use
#     ruby -I ./lib -I ./test test/test_abi.rb


require 'helper'


###
#  adapted from
#    https://github.com/cryptape/ruby-ethereum-abi/blob/master/test/abi_test.rb

def encode_primitive_type( type, arg )
  ABI.encoder.encode_primitive_type( type, arg )
end

def encode_bool( arg )       ABI.encoder.encode_bool( arg ); end
def encode_uint( arg, bits )  ABI.encoder.encode_uint( arg, bits ); end
def encode_uint8( arg )      encode_uint( arg, 8 ); end
def encode_int( arg, bits )   ABI.encoder.encode_int( arg, bits ); end
def encode_int8( arg )      encode_int( arg, 8 ); end
def encode_bytes( arg, length=nil ) ABI.encoder.encode_bytes( arg, length ); end
def encode_address( arg )    ABI.encoder.encode_address( arg ); end

BYTE_ZERO = "\x00".b

def zpad( bin )    ## note: same as builtin String#rjust !!!
  l=32
  return bin  if bin.size >= l
  BYTE_ZERO * (l - bin.size) + bin
end

def zpad_int( n )
  hex = n.to_s(16)
  hex = "0#{hex}"   if hex.size.odd?
  bin = [hex].pack("H*")

  zpad( bin )
end





class TestAbi < MiniTest::Test

  Type  = ABI::Type
  ValueOutOfBounds = ABI::ValueOutOfBounds



  def decode_primitive_type( type, data )
    ABI.decoder.decode_primitive_type( type, data )
  end



  def assert_bin( exp, bin )   ## note: always check for BINARY encoding too
     assert bin.encoding == Encoding::BINARY
     assert_equal exp, bin
  end


  def test_use_abi_class_methods
    types = ['int256']
    args  = [1]
    assert_equal ABI.encode(types, args),
                 ABI::Encoder.new.encode(types, args)
  end



  def test_abi_encode_var_sized_array
    data = BYTE_ZERO * 32 * 3
     types = ['address[]']
     args = [[BYTE_ZERO * 20] * 3]
    assert_bin "#{zpad_int(32)}#{zpad_int(3)}#{data}",
                 ABI.encode(types, args)
  end

  def test_abi_encode_fixed_sized_array
    types  = ['uint16[2]']
    args   = [[5,6]]
    assert_bin "#{zpad_int(5)}#{zpad_int(6)}",
                  ABI.encode( types, args)
  end

  def test_abi_encode_signed_int
    args = [1]
    assert_equal args,  ABI.decode(['int8'], ABI.encode(['int8'], args))

    args = [-1]
    assert_equal args, ABI.decode(['int8'], ABI.encode(['int8'], args))
  end




  def test_abi_encode_primitive_type
    type = Type.parse( 'bool' )
    assert_bin zpad_int(1), encode_primitive_type(type, true)
    assert_bin zpad_int(0), encode_primitive_type(type, false)

    assert_bin zpad_int(1), encode_bool( true )
    assert_bin zpad_int(0), encode_bool( false )


    type = Type.parse( 'uint8' )
    assert_bin zpad_int(255), encode_primitive_type(type, 255)
    assert_raises(ValueOutOfBounds) { encode_primitive_type(type, 256) }

    assert_bin zpad_int(255), encode_uint8( 255 )
    assert_raises(ValueOutOfBounds) { encode_uint8( 256 ) }



    type = Type.parse( 'int8' )
    assert_bin zpad("\x80".b ), encode_primitive_type(type, -128)
    assert_bin zpad("\x7f".b ), encode_primitive_type(type, 127)
    assert_raises(ValueOutOfBounds) { encode_primitive_type(type, -129) }
    assert_raises(ValueOutOfBounds) { encode_primitive_type(type, 128) }

    assert_bin zpad("\x80".b ), encode_int(-128, 8)
    assert_bin zpad("\x7f".b ), encode_int( 127, 8)
    assert_raises(ValueOutOfBounds) { encode_int8( -129 ) }
    assert_raises(ValueOutOfBounds) { encode_int8( 128 ) }



    type = Type.parse( 'bytes' )
    assert_bin "#{zpad_int(3)}\x01\x02\x03#{"\x00"*29}".b,
                    encode_primitive_type(type, "\x01\x02\x03" )
    assert_bin "#{zpad_int(3)}\x01\x02\x03#{"\x00"*29}".b,
                    encode_bytes( "\x01\x02\x03" )


    type = Type.parse( 'bytes8' )
    assert_bin "\x01\x02\x03#{"\x00"*29}".b,
                 encode_primitive_type(type, "\x01\x02\x03" )
    assert_bin "\x01\x02\x03#{"\x00"*29}".b,
                 encode_bytes( "\x01\x02\x03", 8 )


    type = Type.parse( 'address' )
    assert_bin zpad("\xff"*20).b, encode_primitive_type(type, "\xff"*20)
    assert_bin zpad("\xff"*20).b, encode_primitive_type(type, "ff"*20)
    assert_bin zpad("\xff"*20).b, encode_primitive_type(type, "0x"+"ff"*20)

    assert_bin zpad("\xff"*20).b, encode_address( "\xff"*20 )
    assert_bin zpad("\xff"*20).b, encode_address( "ff"*20 )
    assert_bin zpad("\xff"*20).b, encode_address( "0x"+"ff"*20 )
  end



  def test_abi_decode_primitive_type
    type = Type.parse( 'address' )
    assert_equal 'ff'*20,
                   decode_primitive_type(type,
                   encode_primitive_type(type, "0x"+"ff"*20))

    type = Type.parse( 'bytes' )
    assert_equal "\x01\x02\x03",
                    decode_primitive_type(type,
                      encode_primitive_type(type, "\x01\x02\x03"))

    type = Type.parse( 'bytes8' )
    assert_equal ("\x01\x02\x03"+"\x00"*5),
                     decode_primitive_type(type,
                     encode_primitive_type(type, "\x01\x02\x03"))

    type = Type.parse( 'uint8' )
    assert_equal 0, decode_primitive_type(type,
                    encode_primitive_type(type, 0))
    assert_equal 255, decode_primitive_type(type,
                      encode_primitive_type(type, 255))

    type = Type.parse( 'int8' )
    assert_equal -128, decode_primitive_type(type, encode_primitive_type(type, -128))
    assert_equal 127, decode_primitive_type(type, encode_primitive_type(type, 127))

    type = Type.parse( 'bool' )
    assert_equal true, decode_primitive_type(type,
                       encode_primitive_type(type, true))
    assert_equal false, decode_primitive_type(type,
                        encode_primitive_type(type, false))
  end


end   ## class TestAbi

