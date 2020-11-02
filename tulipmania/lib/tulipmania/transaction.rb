

class Transaction

  attr_reader :from, :to, :qty, :what, :id

  def initialize( from, to, qty, what, id=SecureRandom.uuid )
    @from   = from
    @to     = to
    @qty    = qty
    @what   = what      # tulip name - change to name or title - why? why not?
    @id     = id
  end

  def self.from_h( hash )
    self.new *hash.values_at( 'from', 'to', 'qty', 'what', 'id' )
  end

  def to_h
    { from: @from, to: @to, qty: @qty, what: @what, id: @id }
  end


  def valid?
    ## check signature in the future; for now always true
    true
  end

end # class Transaction

Tx = Transaction     ## add Tx shortcut / alias
