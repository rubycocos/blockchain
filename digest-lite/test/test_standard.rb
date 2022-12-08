##
#  to run use
#     ruby -I ./lib -I ./test test/test_standard.rb


require 'helper'



class TestStandard < MiniTest::Test


def test_algos
  pp Digest::MD5.hexdigest( 'abc' )

  pp Digest::RMD160.hexdigest( 'abc' )

  pp  Digest::SHA1.hexdigest( 'abc' )

  pp Digest::SHA2.new(256).hexdigest( 'abc' )  # or
  pp Digest::SHA256.hexdigest( 'abc' )

  pp Digest::SHA2.new(384).hexdigest 'abc'  # or
  pp Digest::SHA384.hexdigest 'abc'

  pp Digest::SHA2.new(512).hexdigest 'abc'   # or
  pp Digest::SHA512.hexdigest 'abc'
end


def test_more_algos
  pp Digest::KeccakLite.new( 256 ).hexdigest( 'abc' )   # or
  pp Digest::KeccakLite.hexdigest( 'abc', 256 )

  pp Digest::SHA3Lite.new( 224 ).hexdigest( 'abc' )  # or
  pp Digest::SHA3Lite.hexdigest( 'abc', 224 )

  pp Digest::SHA3Lite.new( 256 ).hexdigest( 'abc' )  # or
  pp Digest::SHA3Lite.hexdigest( 'abc', 256 )

  pp Digest::SHA3Lite.new( 384 ).hexdigest( 'abc' )  # or
  pp Digest::SHA3Lite.hexdigest( 'abc', 384 )

  pp Digest::SHA3Lite.new( 512 ).hexdigest( 'abc' )  # or
  pp Digest::SHA3Lite.hexdigest( 'abc', 512 )
end

end   # class TestStandard