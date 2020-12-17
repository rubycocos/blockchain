require 'pp'
require 'time'
require 'date'
require 'yaml'
require 'optparse'


## our own code
require 'cryptoquotes/version'    # note: let version always go first





module Quotes

  def self.read_builtin( name )
    name = name.gsub( ' ', '_')   ## auto-convert spaces to underscore (_)
    read( "#{root}/data/#{name}.yml" )
  end

  def self.read( path )  ## read-in a quote dataset - returns an array of hash records
    ## puts "[debug] reading #{path}..."
    txt = File.open( path, 'r:utf-8' ) { |f| f.read }
    data = YAML.load( txt )

    ## auto-fill by-line using filename (convention)
    ##  e.g.    David_Gerard.yml  => David Gerard
    by_line = File.basename( path, File.extname( path ) )
    by_line = by_line.gsub( '_', ' ' )   ## auto-convert underscore (_) back to space
    data.each do |rec|
      rec['by'] = by_line
    end
    data
  end


  def self.sources    ## rename to authors or datafiles or such - why? why not?
    ['Amy_Castor',
     'David_Gerard',
     'Frances_Coppola',
     'Nouriel_Roubini',
     'Patrick_McKenzie',
     'Trolly_McTrollface']
  end

  def self.all
    @all ||= begin
                all = []
                sources.each { |source| all += read_builtin( source ) }
                all
             end
    @all
  end




  def self.lottery
    ## get random shuffle (shuffle three times - why? why not?)
    @lottery ||= (0..(all.size-1)).to_a.shuffle.shuffle.shuffle
  end

  def self.random    ## get a random quote
    idx = lottery.shift   ## remove (shift) first index (ticket) in queue / array
    ## puts "[debug] rand => #{idx} of #{all.size} (remaining #{lottery.size})"
    all[ idx ]
  end
end # module Quotes




module Oracle
  def self.say    ## print a random crypto quote
    q = Quotes.random

    block_indent = 6  ## note: indent by six spaces for now
    ## puts '  Crypto Quote of the Day:'   ## start with an empty line
    puts ''
    q['quote'].each_line do |line|
      print ' ' * block_indent
      print line
    end
    puts ''   ## end with an empty line
    print ' ' * (block_indent+4)
    print "- #{q['by']}"
    print "\n"
    ## todo/fix: add date if availabe (month and year) - why? why not?
    puts ''   ## end with an empty line
  end

  class << self
    alias_method :says, :say
  end


  class Tool
    def run( args )
      opts = { n: 1 }

      parser = OptionParser.new do |cmd|
        cmd.banner = "Usage: oracle [options]"

        cmd.separator "  Print wise oracle sayings / crypto quotes"
        cmd.separator ""
        cmd.separator "  Options:"

        cmd.on("-n", "--number=NUM", "Number of quotes to print (default: #{opts[:n]})", Integer ) do |num|
          opts[:n] = num
        end

        cmd.on("-h", "--help", "Prints this help") do
          puts cmd
          exit
        end
      end

      parser.parse!( args )
      ## pp opts


      n = opts[:n]
      n.times {  Oracle.say }
    end  ## method run
  end # class Tool


  def self.main( args=ARGV )
    Tool.new.run( args )
  end
end  # module Oracle



## puts Quotes.banner
## puts Quotes.root
