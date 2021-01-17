# encoding: utf-8

require 'pp'


## our own code
require 'base58-alphabets/version'    # note: let version always go first

require 'base58-alphabets/base'
require 'base58-alphabets/bitcoin'
require 'base58-alphabets/flickr'
require 'base58-alphabets/base58'



# say hello
puts Base58.banner   if $DEBUG || (defined?($RUBYCOCO_DEBUG) && $RUBYCOCO_DEBUG)
