###
#  to run use
#     ruby -I ./lib sandbox/test_bitcoin.rb


require 'crypto-lite'




puts EC::SECP256K1.order
puts EC::SECP256K1.order.to_s(16).downcase



private_key = EC::PrivateKey.generate     # alice
puts private_key.to_i
puts private_key.to_s
puts private_key.to_i.to_s(16)


private_key = EC::PrivateKey.generate     # bob
puts private_key.to_i
puts private_key.to_s
puts private_key.to_i.to_s(16)




def generate_key
  1 + SecureRandom.random_number( EC::SECP256K1.order - 1 )
end

puts generate_key
puts generate_key



def roll_dice() SecureRandom.random_number(6); end

pp priv_base6 = 99.times.reduce('') { |buf,_| buf << roll_dice.to_s }
#=> "413130205513310000115530450343345150251504444013455422453552225503020102150031231134314351124254004"
priv = priv_base6.to_i(6)
#=> 77254760463198588454157792320308725646096652667800343330432100522222375944308
pp priv.to_s(16)
#=> "aacca516ccbf72dac2c4c447b9f64d12855685e99810ffcf7763a12da6c04074"
pp priv.to_s(2)



private_key = EC::PrivateKey.new( 50303382071965675924643368363408442017264130870580001935435312336103014915707 )

pp public_key =  private_key.public_key   ## the "magic" one-way K=k*G curve multiplication (K=public key,k=private key, G=generator point)
pp point = public_key.point

pp point.x
#=> 17761672841523182714332746445483761684317159074072585653954580096478387916431
pp point.y
#=> 81286693084077906561204577435230199871025343781583806206090259868058973358862

pp point.to_s( :compressed )
#=> "022744c02580b4905349bc481a60c308c2d98d823d44888835047f6bc5c38c4e8f"
pp point.to_s( :uncompressed )
#=> "042744c02580b4905349bc481a60c308c2d98d823d44888835047f6bc5c38c4e8fb3b6a34b90a571f6c2a1113dd5ff4576f61bbf3e970a6e148fa02bf9eb7bcb0e"



puts "checksum:"
# puts checksum('00662ad25db00e7bb38bc04831ae48b4b446d12698') #=> 17d515b6
pp hash256( hex: '00662ad25db00e7bb38bc04831ae48b4b446d12698' ).hexdigest[0..7]

puts "base58:"
pp base58( hex: '00662ad25db00e7bb38bc04831ae48b4b446d1269817d515b6')


puts
puts "wif:"
privatekey = "ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b508258739cb013db2"
pp extended = "80" + privatekey + "01"
#=> "80ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b508258739cb013db201"
pp checksum = hash256( hex: extended ).hexdigest[0..7]
#=> "66557e53"
pp extendedchecksum = extended + checksum
#=> "80ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b508258739cb013db20166557e53"
pp wif = base58( hex: extendedchecksum )
#=> "L5EZftvrYaSudiozVRzTqLcHLNDoVn7H5HSfM9BAN6tMJX8oTWz6"

puts
privatekey = "ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b508258739cb013db2"
pp extended = "80" + privatekey + "01"
#=> "80ef235aacf90d9f4aadd8c92e4b2562e1d9eb97f0df9ba3b508258739cb013db201"
pp wif = base58check( hex: extended )
#=> "L5EZftvrYaSudiozVRzTqLcHLNDoVn7H5HSfM9BAN6tMJX8oTWz6"

