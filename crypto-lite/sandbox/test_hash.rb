###
#  to run use
#     ruby -I ./lib sandbox/test_hash.rb


require 'crypto-lite'


puts "<empty>:"
pp sha256( '' )  #=> 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',


puts "abc:"
pp sha256( "abc" )              #=>
pp sha256( "abc".b )            #=>
pp sha256( "\x61\x62\x63" )
pp sha256( 0x616263 )

pp sha256hex( '616263' )
pp sha256hex( '0x616263' )
pp sha256hex( '0X616263' )
## pp sha256hex( 'hello' )  -- fails - uses non-hex chars

pp sha256( "abc", :openssl )


# a =  dec (97), hex (61), bin (01100001)

puts "---"
puts "a:"
pp sha256( "a" ) #=>
pp sha256( "\x61" )  #=>
pp sha256( 0b01100001 )  #=>
pp sha256( 0x61 )
pp sha256( "a", :openssl )

pp sha256hex( '61' )
pp sha256hex( '0x61' )


puts "b:"
pp sha256( "b" ) #=>
pp sha256( 0b01100010 )  #=>
pp sha256( "b", :openssl )

puts "c:"
pp sha256( "c" ) #=>
pp sha256( 0b01100011 )  #=>
pp sha256( "c", :openssl )


puts "Hello, Cryptos!:"
pp sha256( "Hello, Cryptos!" )


pp keccak256( "Hello, Cryptos!" )
pp rmd160( "Hello, Cryptos!" )


pp hash160hex( '02b9d1cc0b793b03b9f64d022e9c67d5f32670b03f636abf0b3147b34123d13990' )
pp hash160hex( '02b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a8737' )

pp hash256hex( '6fe6b145a3908a4d6616b13c1109717add8672c900' )

puts "bye"
