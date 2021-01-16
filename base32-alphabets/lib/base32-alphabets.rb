# encoding: utf-8

require 'pp'


## our own code
require 'base32-alphabets/version'    # note: let version always go first

require 'base32-alphabets/base'
require 'base32-alphabets/kai'
require 'base32-alphabets/crockford'
require 'base32-alphabets/electrologica'
require 'base32-alphabets/base32'





## add a shortcut (convenience) alias
Kai           = Base32::Kai
Crockford     = Base32::Crockford
Electrologica = Base32::Electrologica


def encode32( num_or_bytes )
  Base32.encode( num_or_bytes )
end

def decode32( str_or_bytes )
  Base32.decode( str_or_bytes )
end


## -- add bytes32 - why? why not?
##
## def bytes32( num_or_str )
##  Base32.bytes( num_or_str )
## end



# say hello
puts Base32.banner   if $DEBUG || (defined?($RUBYCOCO_DEBUG) && $RUBYCOCO_DEBUG)
