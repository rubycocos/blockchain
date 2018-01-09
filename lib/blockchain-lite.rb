# encoding: utf-8


## our own code (without "top-level" shortcuts e.g. "modular version")
require 'blockchain-lite/base'

###
#  add convenience top-level shortcut / alias
#    "standard" default block for now block with proof of work
Block      = BlockchainLite::ProofOfWork::Block
Blockchain = BlockchainLite::Blockchain
