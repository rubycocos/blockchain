
module Ethname

class Record
  def self.directory()  Ethname.directory; end

  def self.find( addr )  directory.find_record( addr ); end
  def self.find_by( name: ) directory.find_record_by( name: name ); end



  def self.parse( row )
    ## note: always downcase addresses for now
    ##   (do NOT use addresss checksum with mixed-hexchars) - why? why not?
     address = row['address'].downcase

     names   = row['names'].split('|')
     names   =  names.map {|name| name.strip }   ## remove leading & trailing withespaces

     ## note: always downcase and normalize (remove space and - for now)
     #  - why? why not?
     ##   e.g. ERC20 => erc20
     ##        ERC-20 | ERC-721 => erc20  | erc721
     interfaces = (row['interfaces'] || '').split('|')
     interfaces = interfaces.map {|inter| inter.downcase.gsub(/[ -]/, '' ) }

     new( address:    address,
          names:      names,
          interfaces: interfaces )
  end


  attr_reader :address, :names, :interfaces

  def initialize( address: nil,
                  names: [],
                  interfaces: [] )
     @address    = address
     @names      = names
     @interfaces = interfaces
  end

  alias_method :addr, :address
  def name() @names[0]; end

  def erc20?()  @interfaces.include?('erc20' ); end
  def erc721?() @interfaces.include?('erc721' ); end


end  # class Record



class Directory
     ## let's you lookup up ethereum addresses by name

     def self.read( *paths )    ## use load - why? why not?
        dir = new
        paths.each do |path|
          rows= read_csv( path )
          dir.add_rows( rows )
        end
        dir
     end



     def initialize
       @recs          = {}   ## lookup (record) by (normalized) address
       @reverse_table = {}   ## lookup (address) by (normalized) name
     end


     def records() @recs.values; end
     def size() @recs.size; end

     def find_record( addr )
       @recs[ addr.downcase ]
     end

     def find_record_by( name: )
       key = normalize( name )
       @reverse_table[ key ]
     end


     def []( name )
        rec = find_record_by( name: name )
        rec ? rec.addr : nil
     end


     def add_rows( rows )
      rows.each do |row|
        rec = Record.parse( row )
        rec.names.each do |name|

          key = normalize( name )
          rec2 = @reverse_table[ key ]

          ## check for duplicates
          raise ArgumentError, "duplicate (normalized) key >#{key} for addr >#{rec.addr}<"  if rec == rec2
          raise ArgumentError, "duplicate (normalized) key >#{key}< for addr >#{rec.addr}; addr already in use >#{rec2.addr}<"  if rec2
          @reverse_table[ key ] = rec
        end

        @recs[rec.addr] = rec
      end
    end

     #################
     #  convencience helpers
     def self.normalize( str )
         ## remove all non a-z (and 0-9) characters
        str.downcase.gsub( /[^a-z0-9]/i, '' )
     end

     def normalize( str ) self.class.normalize( str ); end
end  # class Directory
end  # module Ethname

