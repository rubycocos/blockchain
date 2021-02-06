####################################
#  pending (unconfirmed) transactions (mem) pool

class Pool
  extend Forwardable
  def_delegators :@transactions, :[], :size, :each, :empty?, :any?


  def initialize( transactions=[] )
    @transactions = transactions
  end

  def transactions() @transactions; end

  def <<( tx )
    @transactions << tx
  end


  def update!( txns_confirmed )
    ## find a better name?
    ##  remove confirmed transactions from pool

    ##   document - keep only pending transaction not yet (confirmed) in blockchain ????
    @transactions = @transactions.select do |tx_unconfirmed|
      txns_confirmed.none? { |tx_confirmed| tx_confirmed.id == tx_unconfirmed.id }
    end
  end



  def as_json
    @transactions.map { |tx| tx.to_h }
  end

  def self.from_json( data )
    ## note: assumes data is an array of block records/objects in json
    transactions = data.map { |h| Tx.from_h( h ) }
    self.new( transactions )
  end

end  # class Pool
