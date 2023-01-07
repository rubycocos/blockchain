##
#  to run use
#     ruby -I ./lib -I ./test test/test_fixtures.rb


require 'helper'




class TestFixtures < MiniTest::Test

def test_basic

   tests = read_yml( '../test/abicoder/basic.yml' )
   puts "  #{tests.size} test(s) in /test/abicoder/basic.yml"
   pp tests

    tests.each do |test|
         types = test['types']
         args  = test['args']
         hex   = test['data']

=begin
         ## quick hack for  bytes / bytes10 etc.
         ##   change encoding to BINARAY / ASCII_8BIT
         ##     not really possible with yaml fixtures
         args = types.zip(args).map do |(type,arg)|
                           arg = arg.b   if ['bytes', 'bytes10'].include?( type )
                           arg
                         end
=end
         if hex
           data  = hex( hex )  ## convert hex string to binary string
           bin   = ABI.encode( types, args )
           assert bin.encoding == Encoding::BINARY    ## note: always check for BINARY encoding too
           assert_equal data, bin
             
           assert_equal args,  ABI.decode( types, data )
         end
         assert_equal args, ABI.decode( types, ABI.encode( types, args ))
    end
end


end  ## class TestFixtures

