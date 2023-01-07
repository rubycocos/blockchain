
require 'minitest/autorun'




class String
  ## add bin_to_hex helper method
  ##   note: String#hex already in use (is an alias for String#to_i(16) !!)
  def hexdigest() self.unpack('H*').first; end
end

def hex( hex )  # convert hex(adecimal) string  to binary string
  ## note: strip all whitespaces
  hex = hex.gsub( /[ \t\n\r]/, '' )

 if ['0x', '0X'].include?( hex[0,2] )   ## cut-of leading 0x or 0X if present
   [hex[2..-1]].pack('H*')
 else
   [hex].pack('H*')
 end
end


require 'yaml'

def read_yml( path )
   txt = File.open( path, 'r:utf-8' ) { |f| f.read }
   YAML.load( txt )
end




## our own code
require 'abicoder'
