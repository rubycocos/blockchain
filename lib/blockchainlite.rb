# encoding: utf-8

require 'digest'    # for hash checksum digest function SHA256
require 'pp'        # for pp => pretty printer

require 'date'
require 'time'
require 'json'
require 'uri'



## our own code
require 'blockchainlite/version'    # note: let version always go first
require 'blockchainlite/block'



# say hello
puts BlockchainLite.banner    if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
