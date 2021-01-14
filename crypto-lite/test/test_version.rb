###
#  to run use
#     ruby -I ./lib -I ./test test/test_version.rb


require 'helper'


class TestVersion < MiniTest::Test

def test_version
   pp CryptoLite.version
   pp CryptoLite.banner
   pp CryptoLite.root

   assert true  ## (for now) everything ok if we get here
end

end # class TestVersion
