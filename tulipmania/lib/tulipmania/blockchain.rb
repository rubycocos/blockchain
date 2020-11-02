


class Blockchain
  extend Forwardable
  def_delegators :@chain, :[], :size, :each, :empty?, :any?, :last


  def initialize( chain=[] )
    @chain = chain
  end

  def timestamp1637
      ## change year to 1637 :-)
      ##   note: time (uses signed integer e.g. epoch/unix time starting in 1970 with 0)
      ##  todo: add nano/mili-seconds - why? why not? possible?
      now = Time.now.utc.to_datetime
      past = DateTime.new( 1637, now.month, now.mday, now.hour, now.min, now.sec, now.zone )
      past
    end

  def <<( txs )
    ## todo: check if is block or array
    ##   if array (of transactions) - auto-add (build) block
    ##   allow block - why? why not?
    ##  for now just use transactions (keep it simple :-)

    if @chain.size == 0
      block = Block.first( txs, timestamp: timestamp1637 )
    else
      block = Block.next( @chain.last, txs, timestamp: timestamp1637 )
    end
    @chain << block
  end



  def as_json
    @chain.map { |block| block.to_h }
  end

  def transactions
    ## "accumulate" get all transactions from all blocks "reduced" into a single array
    @chain.reduce( [] ) { |acc, block| acc + block.transactions }
  end



  def self.from_json( data )
    ## note: assumes data is an array of block records/objects in json
    chain = data.map { |h| Block.from_h( h ) }
    self.new( chain )
  end


end  # class Blockchain
