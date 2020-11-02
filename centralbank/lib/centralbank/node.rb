

class Node
  attr_reader :id, :peers, :wallet, :bank

  def initialize( address: )
    @id     = SecureRandom.uuid
    @peers  = []
    @wallet = Wallet.new( address )
    @bank   = Bank.new @wallet.address
  end



  def on_add_peer( host, port )
    @peers << [host, port]
    @peers.uniq!
    # TODO/FIX: no need to send to every peer, just the new one
    send_chain_to_peers
    @bank.pending.each { |tx| send_transaction_to_peers( tx ) }
  end

  def on_delete_peer( index )
    @peers.delete_at( index )
  end


  def on_add_transaction( from, to, amount, id )
    ## note: for now must always pass in id - why? why not? possible tx without id???
    tx = Tx.new( from, to, amount, id )
    if @bank.sufficient_funds?( tx.from, tx.amount ) && @bank.add_transaction( tx )
      send_transaction_to_peers( tx )
      return true
    else
      return false
    end
  end

  def on_send( to, amount )
    tx = @wallet.generate_transaction( to, amount )
    if @bank.sufficient_funds?( tx.from, tx.amount ) && @bank.add_transaction( tx )
      send_transaction_to_peers( tx )
      return true
    else
      return false
    end
  end


  def on_mine!
    @bank.mine_block!
    send_chain_to_peers
  end

  def on_resolve( data )
    chain_new = Blockchain.from_json( data )
    if @bank.resolve!( chain_new )
      send_chain_to_peers
      return true
    else
      return false
    end
  end



private

  def send_chain_to_peers
    data = JSON.pretty_generate( @bank.as_json )   ## payload in json
    @peers.each do |(host, port)|
      Net::HTTP.post(URI::HTTP.build(host: host, port: port, path: '/resolve'), data )
    end
  end

  def send_transaction_to_peers( tx )
    @peers.each do |(host, port)|
      Net::HTTP.post_form(URI::HTTP.build(host: host, port: port, path: '/transactions'), tx.to_h )
    end
  end

end   ## class Node
