



class Exchange
  attr_reader :pending, :chain, :ledger


  def initialize( address )
    @address = address

    @cache = Cache.new( "data.#{address.downcase}.json" )
    h = @cache.read
    if h
      ## restore blockchain
      @chain = Blockchain.from_json( h['chain'] )
      ## restore pending transactions too
      @pending = Pool.from_json( h['transactions'] )
    else
      @chain   = Blockchain.new
      @chain  << [Tx.new( Tulipmania.config.rand_coinbase,
                          @address,
                          Tulipmania.config.mining_reward,
                          Tulipmania.config.rand_tulip )]    # genesis (big bang!) starter block
      @pending = Pool.new
    end

    ## update ledger (balances) with confirmed transactions
    @ledger = Ledger.new( @chain )
  end



  def mine_block!
    add_transaction( Tx.new( Tulipmania.config.rand_coinbase,
                             @address,
                             Tulipmania.config.mining_reward,
                             Tulipmania.config.rand_tulip ))

    ## add mined (w/ computed/calculated hash) block
    @chain << @pending.transactions
    @pending = Pool.new

    ## update ledger (balances) with new confirmed transactions
    @ledger = Ledger.new( @chain )

    @cache.write as_json
  end


  def sufficient_tulips?( wallet, qty, what )
    ## (convenience) delegate for ledger
    ##  todo/check: use address instead of wallet - why? why not?
    ##   for now single address wallet (that is, wallet==address)
    @ledger.sufficient_tulips?( wallet, qty, what )
  end


  def add_transaction( tx )
    if tx.valid? && transaction_is_new?( tx )
      @pending << tx
      @cache.write as_json
      return true
    else
      return false
    end
  end


  ##
  #  check - how to name incoming chain  - chain_new, chain_candidate - why? why not?
  #    what's an intuitive name - what's gets used most often???

  def resolve!( chain_new )
    # TODO this does not protect against invalid block shapes (bogus COINBASE transactions for example)

    if !chain_new.empty? && chain_new.last.valid? && chain_new.size > @chain.size
      @chain  = chain_new
      ## update ledger (balances) with new confirmed transactions
      @ledger = Ledger.new( @chain )

      ##  document - keep only pending (unconfirmed) transaction not yet in blockchain ????
      @pending.update!( @chain.transactions)

      @cache.write as_json
      return true
    else
      return false
    end
  end



  def as_json
    { chain:        @chain.as_json,
      transactions: @pending.as_json
    }
  end



private

  def transaction_is_new?( tx_new )
    ## check if tx exists already in blockchain or pending tx pool

    ## todo: use chain.include?  to check for include
    ##   avoid loop and create new array for check!!!
    (@chain.transactions + @pending.transactions).none? { |tx| tx_new.id == tx.id }
  end

end  ## class Exchange
