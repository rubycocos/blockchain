
require 'minitest/autorun'




class String
  ## add bin_to_hex helper method
  ##   note: String#hex already in use (is an alias for String#to_i(16) !!)
  def hexdigest() self.unpack('H*').first; end
end

def hex( hex )  # convert hex(adecimal) string  to binary string
 if ['0x', '0X'].include?( hex[0,2] )   ## cut-of leading 0x or 0X if present
   [hex[2..-1]].pack('H*')
 else
   [hex].pack('H*')
 end
end



## our own code
require 'abicoder'
