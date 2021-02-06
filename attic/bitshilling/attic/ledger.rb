###
##  old "custom" ledger
##   delete - use ledger-lite library


class Ledger
  attr_reader :wallets     ## use addresses - why? why not? for now single address wallet (wallet==address)

  def initialize( chain=[] )
    @wallets = {}
    chain.each do |block|
      apply_transactions( block.transactions )
    end
  end

  def sufficient_funds?( wallet, amount )
    return true   if Shilling.config.coinbase?( wallet )
    @wallets.has_key?( wallet ) && @wallets[wallet] - amount >= 0
  end


private

  def apply_transactions( transactions )
    transactions.each do |tx|
      if sufficient_funds?(tx.from, tx.amount)
        @wallets[tx.from] -= tx.amount   unless Shilling.config.coinbase?( tx.from )
        @wallets[tx.to] ||= 0
        @wallets[tx.to] += tx.amount
      end
    end
  end

end   ## class Ledger
