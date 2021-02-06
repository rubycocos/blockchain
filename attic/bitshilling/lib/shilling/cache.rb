

class Cache
  def initialize( name )
    @name = name
  end

  def write( data )
    File.open( @name, 'w:utf-8' ) do |f|
      f.write JSON.pretty_generate( data )
    end
  end

  def read
    if File.exists?( @name )
      data = File.open( @name, 'r:bom|utf-8' ).read
      JSON.parse( data )
    else
      nil
    end
  end
end   ## class Cache
