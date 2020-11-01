# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_version.rb


require 'helper'


class TestVersion < MiniTest::Test

def test_version
   pp BlockchainLite.version
   pp BlockchainLite.banner
   pp BlockchainLite.root

   assert true  ## (for now) everything ok if we get here
end

end # class TestVersion
