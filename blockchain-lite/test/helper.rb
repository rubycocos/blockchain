## $:.unshift(File.dirname(__FILE__))

## minitest setup

require 'minitest/autorun'


## our own code

require 'blockchain-lite/base'    ## note: use "modular" version without "top-level" Block constant


module Basic
  Block = BlockchainLite::Basic::Block    ## convenience shortcut

  class Blockchain < BlockchainLite::Blockchain
    def block_class() Block; end
  end
end # module Basic


module ProofOfWork
  Block = BlockchainLite::ProofOfWork::Block    ## convenience shortcut

  class Blockchain < BlockchainLite::Blockchain
    def block_class() Block; end
  end
end  # module ProofOfWork
