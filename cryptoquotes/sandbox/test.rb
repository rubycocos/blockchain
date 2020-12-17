$LOAD_PATH.unshift( "./lib" )
require 'cryptoquotes'






quotes = Quotes.read_builtin( 'David_Gerard' )
pp quotes

pp Quotes.all


puts "---"
q = Quotes.random
pp q
puts "---"
q = Quotes.random
pp q
puts "---"
q = Quotes.random
pp q
puts q['quote']

Oracle.say
Oracle.say
Oracle.says

puts "bye"