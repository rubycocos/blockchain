###
#  to run use
#     ruby -I ./lib sandbox/test_names.rb

require 'ethname'



pp Ethname.directory.records
puts "  #{Ethname.directory.size} (contract) address record(s)"


puts "bye"