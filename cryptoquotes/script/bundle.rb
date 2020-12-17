#################
#  update (get) the crypto quotes bundled with this gem
#    from the source:
#      https://github.com/openblockchains/crypto-quotes
#
#  to run use:
#     ruby script/bundle.rb


require 'fileutils'


files = Dir.glob( '/sites/openblockchains/crypto-quotes/*.yml' )

puts "sources:"
pp files
puts

files.each_with_index do |file,i|
  basename = File.basename( file )
  dest = "./data/#{basename}"
  puts "[#{i+1}/#{files.size}] copying to #{dest}..."
  FileUtils.cp( file, dest )
end

puts
puts "   done - copied #{files.size} file(s)"