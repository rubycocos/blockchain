# encoding: utf-8

require 'digest'
require 'pp'
require 'date'
require 'time'
require 'json'
require 'uri'

## our own code
require 'blockchain-lite/version' # note: let version always go first
require 'blockchain-lite/basic/block'
require 'blockchain-lite/proof_of_work/block'
require 'blockchain-lite/blockchain'
require 'blockchain-lite/block' ## configure "standard" default block (e.g. basic, proof-of-work, etc.)

# say hello
if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
  puts BlockchainLite.banner
end
