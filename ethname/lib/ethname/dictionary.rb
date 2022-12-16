
module Ethname

  class Dictionary
     ## let's you lookup up ethereum addresses by name

     def self.read( *paths )    ## use load - why? why not?
        dict = new
        paths.each do |path|
          recs = read_csv( path )
          dict.add_recs( recs )
        end
        dict
     end



     def initialize
       @recs          = []
       @reverse_table = {}   ## lookup (address) by (normalized) name
     end

     def recs() @recs; end
     def size() @recs.size; end



     def lookup( q )
        key = normalize( q )
        addr = @reverse_table[ key ]
        addr
     end
     alias_method :[], :lookup


     def add_recs( recs )
      recs.each do |rec|
        ## note: always downcase addresses for now
        ##   (do NOT use addresss checksum with mixed-hexchars) - why? why not?
        addr =  rec['address'].downcase
        names = rec['names'].split('|')
        names.each do |name|
          _add( addr, name )
        end
      end

      @recs += recs
    end


     #################
     #  convencience helpers
     def self.normalize( str )
         ## remove all non a-z (and 0-9) characters
        str.downcase.gsub( /[^a-z0-9]/i, '' )
     end

     def normalize( str ) self.class.normalize( str ); end

     ####
     # private (internal) helpers
     def _add( addr, name )
      key = normalize( name )
      addr2 = @reverse_table[ key ]

      ## check for duplicates
      raise ArgumentError, "duplicate (normalized) key >#{key} for addr >#{addr}<"  if addr == addr2
      raise ArgumentError, "duplicate (normalized) key >#{key}< for addr >#{addr}; addr already in use >#{addr2}<"  if addr2
      @reverse_table[ key ] = addr
      self
   end

  end
end  # module Ethname

