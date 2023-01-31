
###
#  read all contract metadata


class Meta
  def initialize( data )
     @data = data
     ## split and normalize names
     @names = (data['name'] || data['names'])
                       .split( '|' )
                       .map { |name| name.gsub(/[ \t]+/, ' ' ).strip }
  end

  def name() @names[0]; end
  def names() @names; end

  def timestamp() @data['timestamp']; end
  def created()
    ## use timestamp for now and ignore created for now - why? why not?
     Time.at( @data['timestamp'] ).utc
  end

  def address()   @data['address']; end
  alias_method :addr, :address
  def txid()      @data['txid']; end
  def creator()   @data['creator']; end
  def block()     @data['block']; end   ## add blocknumber alias - why? why not?
end  # class Meta


def each_contract( &block )
   recs = read_meta
   recs.each do |rec|
     block.call( Meta.new( rec ) )
   end
end


def read_meta( basedir='./address' )
  puts "==> read contract metadata..."

  ## collection all addresses
  recs = []
  paths = Dir.glob( "#{basedir}/**/contract.yml" )
  ## paths = paths[0..2]
  paths.each do |path|
     data = read_yaml( path )

     ## auto-add basedir or such - why? why not?

     ## auto-add addr or dobule check - why? why not?
     ## basename = File.basename( File.dirname( path ))

     recs << data
  end

  ############
  ## sort by block  (reverse chronological)
  recs = recs.sort do |l,r|
    l['block'] <=> r['block']
  end

  ## pp recs
  ## puts "   #{recs.size} record(s)"

  recs
end
