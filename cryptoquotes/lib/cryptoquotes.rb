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
    txt = File.open( path, 'r:utf-8' ) { |f| f.read }
    data = YAML.load( txt )
    ## todo/fix: auto-add by-line via file basename!!!
    data
  end

  def self.all
    @all ||= begin
                read_builtin( 'David_Gerard' )
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
    print '- David Gerard'
    print "\n"
    ## todo/fix: add date if availabe (month and year) - why? why not?
    puts ''   ## end with an empty line
  end
end  # module Oracle

pp Quotes.banner
pp Quotes.root
