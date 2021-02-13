## 3rd party
require 'crypto-lite'
require 'chunky_png'
require 'csvreader'


## extra stdlibs
require 'fileutils'
require 'optparse'



## our own code
require 'cryptopunks/version'    # note: let version always go first
require 'cryptopunks/attributes'
require 'cryptopunks/structs'
require 'cryptopunks/image'
require 'cryptopunks/dataset'



module Cryptopunks
class Tool
  def run( args )
    opts = { zoom: 1,
             outdir: '.',
             file:  './punks.png',
           }

    parser = OptionParser.new do |cmd|
      cmd.banner = "Usage: punk (or cryptopunk) [options] IDs"

      cmd.separator "  Mint punk characters from composite (#{opts[:file]}) - for IDs use 0 to 9999"
      cmd.separator ""
      cmd.separator "  Options:"

      cmd.on("-z", "--zoom=ZOOM", "Zoom factor x2, x4, x8, etc. (default: #{opts[:zoom]})", Integer ) do |zoom|
        opts[:zoom] = zoom
      end

      cmd.on("-d", "--dir=DIR", "Output directory (default: #{opts[:outdir]})", String ) do |outdir|
        opts[:outdir] = outdir
      end

      cmd.on("-f", "--file=FILE", "True Official Genuine CryptoPunks™ composite image (default: #{opts[:file]})", String ) do |file|
        opts[:file] = file
      end


      cmd.on("-h", "--help", "Prints this help") do
        puts cmd
        exit
      end
    end

    parser.parse!( args )

    puts "opts:"
    pp opts

    puts "==> reading >#{opts[:file]}<..."
    punks = Image.read( opts[:file] )


    puts "    setting zoom to #{opts[:zoom]}x"   if opts[:zoom] != 1
    punks.zoom = opts[:zoom]   ## note: always reset zoom even if 1

    ## make sure outdir exits (default is current working dir e.g. .)
    FileUtils.mkdir_p( opts[:outdir] )  unless Dir.exist?( opts[:outdir] )

    args.each_with_index do |arg,index|
      punk_index = arg.to_i
      punk_name  = "punk-" + "%04d" % punk_index

      ##  if zoom - add x2,x4 or such
      punk_name << "x#{opts[:zoom]}"   if opts[:zoom] != 1

      path  = "#{opts[:outdir]}/#{punk_name}.png"
      puts "==> (#{index+1}/#{args.size}) minting punk ##{punk_index}; writing to >#{path}<..."

      punks[ punk_index ].save( path )
    end

    puts "done"
  end  ## method run
end # class Tool


def self.main( args=ARGV )
  Tool.new.run( args )
end
end ## module Cryptopunks



### add some convenience shortcuts
CryptoPunks = Cryptopunks
Punks       = Cryptopunks




puts Cryptopunks.banner    # say hello
