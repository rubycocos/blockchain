##
#  to run use
#     ruby -I ./lib -I ./test test/test_abi.rb


require 'helper'


###
#  adapted from
#    https://github.com/cryptape/ruby-ethereum-abi/blob/master/test/abi_test.rb

class TestAbi < MiniTest::Test

  include ABI::Helpers   ## e.g. zpad_int

  Type  = ABI::Type
  ValueOutOfBounds = ABI::ValueOutOfBounds

  def encode_primitive_type( type, arg )
    ABI.codec.encode_primitive_type( type, arg )
  end
  def decode_primitive_type( type, data )
    ABI.codec.decode_primitive_type( type, data )
  end


  BYTE_ZERO = "\x00".b


  def test_use_abi_class_methods
    types = ['int256']
    args  = [1]
    assert_equal ABI.encode(types, args),
                 ABI.codec.encode_abi(types, args)
  end

  def test_abi_encode_var_sized_array
    bytes = BYTE_ZERO * 32 * 3
     types = ['address[]']
     args = [[BYTE_ZERO * 20] * 3]
    assert_equal "#{zpad_int(32)}#{zpad_int(3)}#{bytes}",
                 ABI.encode(types, args)
  end

  def test_abi_encode_fixed_sized_array
    types  = ['uint16[2]']
    args   = [[5,6]]
    assert_equal "#{zpad_int(5)}#{zpad_int(6)}",
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
    assert_equal zpad_int(1), encode_primitive_type(type, true)
    assert_equal zpad_int(0), encode_primitive_type(type, false)

    type = Type.parse( 'uint8' )
    assert_equal zpad_int(255), encode_primitive_type(type, 255)
    assert_raises(ValueOutOfBounds) { encode_primitive_type(type, 256) }


   ### todo/fix:
   ##    check for encoding e.g. BINARY/ASCII_8BIT from encode_primitive_type
   ##      should really be always  BINARY/ASCII_8BIT  - why? why not?
    type = Type.parse( 'int8' )
    assert_equal zpad("\x80", 32).b, encode_primitive_type(type, -128)
    assert_equal zpad("\x7f", 32).b, encode_primitive_type(type, 127)
    assert_raises(ValueOutOfBounds) { encode_primitive_type(type, -129) }
    assert_raises(ValueOutOfBounds) { encode_primitive_type(type, 128) }

    type = Type.parse( 'bytes' )
    assert_equal "#{zpad_int(3)}\x01\x02\x03#{"\x00"*29}",
                  encode_primitive_type(type, "\x01\x02\x03")

    type = Type.parse( 'bytes8' )
    assert_equal "\x01\x02\x03#{"\x00"*29}",
                 encode_primitive_type(type, "\x01\x02\x03")

    type = Type.parse( 'address' )
    assert_equal zpad("\xff"*20, 32), encode_primitive_type(type, "\xff"*20)
    assert_equal zpad("\xff"*20, 32).b, encode_primitive_type(type, "ff"*20)
    assert_equal zpad("\xff"*20, 32).b, encode_primitive_type(type, "0x"+"ff"*20)
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
    assert_equal -128, decode_primitive_type(type,
                       encode_primitive_type(type, -128))
    assert_equal 127, decode_primitive_type(type,
                      encode_primitive_type(type, 127))

    type = Type.parse( 'bool' )
    assert_equal true, decode_primitive_type(type,
                       encode_primitive_type(type, true))
    assert_equal false, decode_primitive_type(type,
                        encode_primitive_type(type, false))
  end


end   ## class TestAbi

