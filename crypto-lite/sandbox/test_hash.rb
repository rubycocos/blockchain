###
#  to run use
#     ruby -I ./lib sandbox/test_hash.rb


require 'crypto-lite'


puts "<empty>:"
pp sha256( '' ).hexdigest  #=> 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',


puts "abc:"
pp sha256( "abc" ).hexdigest              #=>
pp sha256( "abc".b ).hexdigest            #=>
pp sha256( "\x61\x62\x63" ).hexdigest
## pp sha256( 0x616263 )

pp sha256( hex: '616263' ).hexdigest
pp sha256( hex: '0x616263' ).hexdigest
pp sha256( hex: '0X616263' ).hexdigest
## pp sha256( hex: 'hello' )  -- fails - uses non-hex chars

pp sha256( "abc", engine: 'openssl' ).hexdigest


# a =  dec (97), hex (61), bin (01100001)

puts "---"
puts "a:"
pp sha256( "a" ).hexdigest #=>
pp sha256( "\x61" ).hexdigest  #=>
## pp sha256( 0b01100001 )  #=>
## pp sha256( 0x61 )
pp sha256( "a", engine: 'openssl' ).hexdigest

pp sha256( hex: '61' ).hexdigest
pp sha256( hex: '0x61' ).hexdigest


puts "b:"
pp sha256( "b" ).hexdigest #=>
## pp sha256( 0b01100010 )  #=>
pp sha256( "b", engine: 'openssl' ).hexdigest

puts "c:"
pp sha256( "c" ).hexdigest #=>
## pp sha256( 0b01100011 )  #=>
pp sha256( "c", engine: 'openssl' ).hexdigest


puts "Hello, Cryptos!:"
pp sha256( "Hello, Cryptos!" ).hexdigest


pp keccak256( "Hello, Cryptos!" ).hexdigest
pp rmd160( "Hello, Cryptos!" ).hexdigest


pp hash160( hex: '02b9d1cc0b793b03b9f64d022e9c67d5f32670b03f636abf0b3147b34123d13990' ).hexdigest
pp hash160( hex: '02b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a8737' ).hexdigest

pp hash256( hex: '6fe6b145a3908a4d6616b13c1109717add8672c900' ).hexdigest


pp sha256( "Satoshi Nakamoto" ).hexdigest
pp sha256( "Satoshi Nakamot0" ).hexdigest



puts "bye"
