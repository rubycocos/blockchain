require 'minitest/autorun'

require 'bytes'


## extend String
class String
  alias_method :hexdigest, :bin_to_hex   ## note: bin_to_hex added via Bytes!!!
end



def decode_string( bin )
    pos_bin = bin[0,32]   ## first word (32 bytes) holds start position of type
    pos = pos_bin.hexdigest.to_i( 16 )

    if pos != 32
      putx "!! ERROR - decoding - expected start pos 32; got: #{pos}"
      exit 1
    end

    ## convert big endian integer encoded byte string to integer
    size_bin = bin[32,32]
    size_hex = size_bin.hexdigest
    size =  size_hex.to_i(16)
    puts "  string of size: #{size} (0x#{size_hex})"
    puts "    bytes available in buffer: #{bin.size - 64}"

     ## note. use size - no need to remove right zero padding??
    str = bin[64,size]
    str.force_encoding( Encoding::UTF_8 )
    str   ## todo/check:   change encoding to utf-8 or such (from binary - why? why not?)
end



class TestDecode < MiniTest::Test

  MOONBIRDS_TOKEN_URI = [
    ["https://live---metadata-5covpqijaa-uc.a.run.app/metadata/0",
     "0000000000000000000000000000000000000000000000000000000000000020
      000000000000000000000000000000000000000000000000000000000000003a
      68747470733a2f2f6c6976652d2d2d6d657461646174612d35636f767071696a
      61612d75632e612e72756e2e6170702f6d657461646174612f30000000000000"],
    ["https://live---metadata-5covpqijaa-uc.a.run.app/metadata/1",
     "0000000000000000000000000000000000000000000000000000000000000020
      000000000000000000000000000000000000000000000000000000000000003a
      68747470733a2f2f6c6976652d2d2d6d657461646174612d35636f767071696a
      61612d75632e612e72756e2e6170702f6d657461646174612f31000000000000"],
  ]

  def test_moonbirds
    MOONBIRDS_TOKEN_URI.each do |str, hex|
      assert_equal str, decode_string( hex.gsub( /[ \n\r]/, '' ).hex_to_bin )
    end
  end
end  ## class TestDecode

