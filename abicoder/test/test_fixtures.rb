##
#  to run use
#     ruby -I ./lib -I ./test test/test_fixtures.rb


require 'helper'




class TestFixtures < MiniTest::Test


## little helper to (recursively) convert 0x hex strings to binary strings
##    other option to use binary in yaml is using !!binary with base64 encoding
def hex_to_bin( arg )
  if arg.is_a?( Array )
    arg.map { |item| hex_to_bin( item ) }
  elsif arg.is_a?( String ) && arg =~ /\A0x[0-9a-fA-F]{2,}\z/
    hex = arg[2..-1]
    bin = [hex].pack("H*")
    puts "  converting hex >#{arg}< to bin  >#{bin.inspect}< #{bin.size} byte(s)"
    bin
  else
    arg
  end
end


def assert_test( test )
  types = test['types']
  args  = test['args']
  hex   = test['data']


  puts "==> testing #{types}...:"
  args  = hex_to_bin( args )

  types.zip( args ).each_with_index do |(type,arg),i|
    puts "  [#{i}] #{type}  =>  #{arg.inspect}"
    ## pp ABI::Type.parse( type )
  end

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


def xx_test_basic
   tests = read_yml( '../test/abicoder/basic.yml' )
   puts "  #{tests.size} test(s) in /test/abicoder/basic.yml"
   pp tests

    tests.each do |test|
       assert_test test
    end
end

def test_more
  tests = read_yml( '../test/abicoder/more.yml' )
  puts "  #{tests.size} test(s) in /test/abicoder/more.yml"
  pp tests

   tests.each do |test|
      assert_test test
   end
end

end  ## class TestFixtures

