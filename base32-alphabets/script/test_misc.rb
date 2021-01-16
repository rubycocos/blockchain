# encoding: utf-8

###
#  to run use
#     ruby -I ./lib script/test_misc.rb


require 'base32-alphabets'


binary = 0b0000000000000000010010100101001010010011000111001110010000001000010111000001010010111101110011100000000101001010000000110001100010000100011010100000110010000000100011000110000000101001010010100110001100010100101000110100101000010010100101011011100111001110  # binary
hex    = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a_1295_b9ce   # hex

hex2    = 0x000002931ce4085c14bdce014a0318846a0c808c60294a6314a34a_1295_b9ce   # hex

pp binary == hex
# => true

kai    = "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff".gsub( ' ', '' )

pp Base32::BASE

pp Kai::ALPHABET

pp Kai.encode( binary )
## pp Base32.fmt( kai )
pp Kai.fmt( kai )


pp Kai::BINARY

=begin
hash = {}
Base32::Kai::ALPHABET.each_char.with_index do |char,index|
  puts "#{char} => #{index} #{'%05b' % index}"
  hash[char] = '%05b' % index
end
pp hash
=end


pp Electrologica::ALPHABET
puts "--encode:"
kitty = Electrologica.encode( binary )
pp kitty
puts "---decode:"
pp Electrologica.decode( kitty )
pp Electrologica.decode( Electrologica.encode( binary ))
puts "---"
pp binary
kitty = Electrologica.encode( hex2 )
pp Electrologica.fmt( kitty )
pp Electrologica.fmt( kitty, sep: '/' )
pp Electrologica.decode( Electrologica.fmt( kitty ))
pp Electrologica.encode( 400 )
pp Electrologica.decode( "12-16" )


pp Crockford::ALPHABET

pp Crockford.encode( binary )

pp Electrologica.fmt( Electrologica.encode( binary ))
pp Electrologica.fmt( Electrologica.encode( binary ), sep: '/')
pp Crockford.fmt( Crockford.encode( binary ))
pp Kai.fmt( Kai.encode( binary ))


pp Crockford::BINARY


pp Base32.format
pp Base32.alphabet
pp Base32.alphabet[0]
pp Base32.number
pp Base32.number['a']

pp Base32.fmt( Base32.encode( binary ))
pp encode32( binary )


Base32.format = :num
pp Base32.format
pp Base32.alphabet
pp Base32.alphabet[0]
pp Base32.number
pp Base32.number['10']

pp Base32.fmt( Base32.encode( binary ))
pp encode32( binary )
