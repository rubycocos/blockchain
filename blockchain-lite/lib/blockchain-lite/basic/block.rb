# encoding: utf-8

module BlockchainLite
  module Basic


class Block

  attr_reader :index
  attr_reader :timestamp
  attr_reader :transactions_count   # use alias - txn_count - why? why not?
  attr_reader :transactions         # use alias - txn       - why? why not?
  attr_reader :previous_hash
  attr_reader :hash

  def initialize(index, transactions, previous_hash, timestamp: nil)
    @index              = index

    ## note: use coordinated universal time (utc)
    ##    auto-add timestamp for new blocks (e.g. timestamp is nil)
    @timestamp          = timestamp ? timestamp : Time.now.utc

    ## note: assumes / expects an array for transactions
    @transactions       = transactions
    @transactions_count = transactions.size

    @previous_hash      = previous_hash
    @hash               = calc_hash
  end

  def calc_hash
    sha = Digest::SHA256.new
    sha.update( @timestamp.to_s +
                @transactions.to_s +
                @previous_hash )
    sha.hexdigest
  end



  def self.first( *args )    # create genesis (big bang! first) block
    ##  note: allow/support splat-* for now for convenience (auto-wraps args into array)
    if args.size == 1 && args[0].is_a?( Array )
      transactions = args[0]   ## "unwrap" array in array
    else
      transactions = args      ## use "auto-wrapped" splat array
    end
    ## uses index zero (0) and arbitrary previous_hash ('0')
    Block.new( 0, transactions, '0'  )
  end

  def self.next( previous, *args )
    ## note: allow/support splat-* for now for convenience (auto-wraps args into array)
    if args.size == 1 && args[0].is_a?( Array )
      transactions = args[0]   ## "unwrap" array in array
    else
      transactions = args      ## use "auto-wrapped" splat array
    end
    Block.new( previous.index+1, transactions, previous.hash )
  end

end  # class Block


end  ##  module Basic
end  ##  module BlockchainLite
