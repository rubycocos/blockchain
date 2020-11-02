
class Ledger
  attr_reader :wallets     ## use addresses - why? why not? for now single address wallet (wallet==address)

  def initialize( chain=[] )
    @wallets = {}
    chain.each do |block|
      apply_transactions( block.transactions )
    end
  end

  def sufficient_tulips?( wallet, qty, what )
    return true   if Tulipmania.config.coinbase?( wallet )

    @wallets.has_key?( wallet ) &&
    @wallets[wallet].has_key?( what ) &&
    @wallets[wallet][what] - qty >= 0
  end


private

  def apply_transactions( transactions )
    transactions.each do |tx|
      if sufficient_tulips?(tx.from, tx.qty, tx.what)
        @wallets[tx.from][tx.what] -= tx.qty   unless Tulipmania.config.coinbase?( tx.from )
        @wallets[tx.to] ||= {}   ## make sure wallet exists (e.g. init with empty hash {})
        @wallets[tx.to][tx.what] ||= 0
        @wallets[tx.to][tx.what] += tx.qty
      end
    end
  end

end   ## class Ledger
