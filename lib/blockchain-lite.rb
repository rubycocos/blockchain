# encoding: utf-8

require 'digest'    # for hash checksum digest function SHA256
require 'pp'        # for pp => pretty printer

require 'date'
require 'time'
require 'json'
require 'uri'


## 3rd party libs
require 'merkletree'


## our own code
require 'blockchain-lite/version'    # note: let version always go first

require 'blockchain-lite/basic/block'
require 'blockchain-lite/proof_of_work/block'

require 'blockchain-lite/blockchain'

require 'blockchain-lite/block'       ## configure "standard" default block (e.g. basic, proof-of-work, etc.)



# say hello
puts BlockchainLite.banner    if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
