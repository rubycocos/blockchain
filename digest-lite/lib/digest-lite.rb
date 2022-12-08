require 'digest'

## our own code
require_relative 'digest-lite/version'   # note: let version always go first
require_relative 'digest-lite/keccak'
require_relative 'digest-lite/sha3'


##
## add camcel case alias - why? why not?
DigestLite = Digestlite


puts Digestlite ## say hello