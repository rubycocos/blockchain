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
end ## module Cryptopunks
