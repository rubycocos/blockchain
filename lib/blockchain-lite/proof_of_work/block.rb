# encoding: utf-8

module BlockchainLite
  module ProofOfWork


class Block

  attr_reader :index
  attr_reader :timestamp
  attr_reader :transactions_count   # use alias - txn_count - why? why not?
  attr_reader :transactions         # use alias - txn       - why? why not?
  attr_reader :previous_hash
  attr_reader :nonce                # ("lucky" number used once) - proof of work if hash starts with leading zeros (00)
  attr_reader :hash

  def initialize(index, transactions, previous_hash, timestamp: nil, nonce: nil)
    @index = index

    ## note: assumes / expects an array for transactions
    @transactions       = transactions
    @transactions_count = transactions.size

    @previous_hash = previous_hash

    ## note: use coordinated universal time (utc)
    @timestamp = timestamp ? timestamp : Time.now.utc

    if nonce     ## restore pre-computed/mined block (from disk/cache/db/etc.)
       ## todo: check timestamp MUST NOT be nil
       @nonce = nonce
       @hash  = calc_hash
    else   ## new block  (mine! e.g. find nonce - "lucky" number used once)
       @nonce, @hash = compute_hash_with_proof_of_work
    end
  end

  def calc_hash
    calc_hash_with_nonce( @nonce )
  end



  def self.first( *transactions )    # create genesis (big bang! first) block
    ##  note: allow/support splat-* for now for convenience (auto-wraps args into array)
    if transactions.size == 1 && transactions[0].is_a?( Array )
      t = transactions[0]   ## "unwrap" array in array
    else
      t = transactions      ## use "auto-wrapped" splat array
    end
    ## uses index zero (0) and arbitrary previous_hash ('0')
    Block.new( 0, t, '0'  )
  end

  def self.next( previous, *transactions )
    ## note: allow/support splat-* for now for convenience (auto-wraps args into array)
    if transactions.size == 1 && transactions[0].is_a?( Array )
      t = transactions[0]   ## "unwrap" array in array
    else
      t = transactions      ## use "auto-wrapped" splat array
    end
    Block.new( previous.index+1, t, previous.hash )
  end


private
  def calc_hash_with_nonce( nonce=0 )
    sha = Digest::SHA256.new
    sha.update( nonce.to_s +
                @index.to_s +
                @timestamp.to_s +
                @transactions.to_s +
                @transactions_count.to_s +
                @previous_hash )
    sha.hexdigest
  end

  def compute_hash_with_proof_of_work( difficulty='00' )
    nonce = 0
    loop do
      hash = calc_hash_with_nonce( nonce )
      if hash.start_with?( difficulty )
        return [nonce,hash]    ## bingo! proof of work if hash starts with leading zeros (00)
      else
        nonce += 1             ## keep trying (and trying and trying)
      end
    end
  end

end  # class Block


end  ##  module ProofOfWork
end  ##  module BlockchainLite
