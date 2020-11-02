

class Transaction

  attr_reader :from, :to, :amount, :id

  def initialize( from, to, amount, id=SecureRandom.uuid )
    @from   = from
    @to     = to
    @amount = amount
    @id     = id
  end

  def self.from_h( hash )
    self.new *hash.values_at( 'from', 'to', 'amount', 'id' )
  end

  def to_h
    { from: @from, to: @to, amount: @amount, id: @id }
  end


  def valid?
    ## check signature in the future; for now always true
    true
  end

end # class Transaction

Tx = Transaction     ## add Tx shortcut / alias
