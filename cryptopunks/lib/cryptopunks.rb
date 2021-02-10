## 3rd party
require 'crypto-lite'
require 'chunky_png'

## extra stdlibs
require 'fileutils'
require 'optparse'



## our own code
require 'cryptopunks/version'    # note: let version always go first


module Cryptopunks
class Image
  def self.read( path='./punks.png' )
    data = File.open( path, 'rb' ) { |f| f.read }
    new( data )
  end


  attr_accessor :zoom

  PUNK_ROWS   = 100
  PUNK_COLS   = 100
  PUNK_COUNT  = PUNK_ROWS * PUNK_COLS    ## 10_000 = 100x100  (24000x24000 pixel)

  PUNK_HEIGHT = 24
  PUNK_WIDTH  = 24

  PUNK_HASH   = 'ac39af4793119ee46bbff351d8cb6b5f23da60222126add4268e261199a2921b'


  def initialize( data )
    @punks = ChunkyPNG::Image.from_blob( data )
    puts "     #{@punks.height}x#{@punks.width} (height x width)"

    ## check sha256 checksum
    @hexdigest = sha256( data )
    if original?
       puts "     >#{@hexdigest}< SHA256 hash matching"
       puts "         ✓ True Official Genuine CryptoPunks™ verified"
    else
       puts " !! ERROR: >#{hexdigest}< SHA256 hash NOT matching"
       puts "           >#{PUNK_HASH}< expected for True Official Genuine CryptoPunks™."
       puts ""
       puts "     Sorry, please download the original."
       exit 1
    end

    @zoom  = 1
  end


  def hexdigest()  @hexdigest end

  def verify?()  @hexdigest == PUNK_HASH; end
  alias_method :genuine?,  :verify?
  alias_method :original?, :verify?



  def size() PUNK_COUNT; end

  def []( index )
    @zoom == 1 ? crop( index ) : scale( index, @zoom )
  end


  def crop( index  )
    y, x = index.divmod( PUNK_ROWS )
    @punks.crop( x*PUNK_WIDTH, y*PUNK_HEIGHT, PUNK_WIDTH, PUNK_HEIGHT )
  end


  def scale( index, zoom )
    punk = ChunkyPNG::Image.new( PUNK_WIDTH*zoom, PUNK_HEIGHT*zoom,
                                 ChunkyPNG::Color::WHITE )

    ## (x,y) offset in big all-in-one punks image
    y, x = index.divmod( PUNK_ROWS )

    ## copy all 24x24 pixels
    PUNK_WIDTH.times do |i|
      PUNK_HEIGHT.times do |j|
        pixel = @punks[i+x*PUNK_WIDTH, j+y*PUNK_HEIGHT]
        zoom.times do |n|
          zoom.times do |m|
            punk[n+zoom*i,m+zoom*j] = pixel
          end
        end
      end
    end
    punk
  end
end ## class Image



class Tool
  def run( args )
    opts = { zoom: 1,
             outdir: '.',
             file:  './punks.png',
           }

    parser = OptionParser.new do |cmd|
      cmd.banner = "Usage: cryptopunks [options] IDs"

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
