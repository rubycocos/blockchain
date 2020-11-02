

Block = BlockchainLite::ProofOfWork::Block

## see https://github.com/openblockchains/blockchain.lite.rb/blob/master/lib/blockchain-lite/proof_of_work/block.rb


######
#  add more methods

class Block

def to_h
  { index:         @index,
    timestamp:     @timestamp,
    nonce:         @nonce,
    transactions:  @transactions.map { |tx| tx.to_h },
    previous_hash: @previous_hash }
end

def self.from_h( h )
  transactions = h['transactions'].map { |h_tx| Tx.from_h( h_tx ) }

  ## parse iso8601 format e.g 2017-10-05T22:26:12-04:00
  timestamp    = Time.parse( h['timestamp'] )

  self.new( h['index'],
            transactions,
            h['previous_hash'],
            timestamp: timestamp,
            nonce: h['nonce'].to_i )
end


def valid?
  true   ## for now always valid
end


end # class Block
