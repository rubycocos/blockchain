###
#  to run use
#     ruby -I ./lib sandbox/test_script.rb


require 'cryptopunks'


punks = Punks::Image.read( './punks.png' )

pp punks.hexdigest
pp punks.size


puts "bye"
