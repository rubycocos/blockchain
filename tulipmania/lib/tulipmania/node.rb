

class Node
  attr_reader :id, :peers, :wallet, :exchange


  def initialize( address: )
    @id       = SecureRandom.uuid
    @peers    = []
    @wallet   = Wallet.new( address )
    @exchange = Exchange.new @wallet.address
  end


  def on_add_peer( host, port )
    @peers << [host, port]
    @peers.uniq!
    # TODO/FIX: no need to send to every peer, just the new one
    send_chain_to_peers
    @exchange.pending.each { |tx| send_transaction_to_peers( tx ) }
  end

  def on_delete_peer( index )
    @peers.delete_at( index )
  end


  def on_add_transaction( from, to, qty, what, id )
    ## note: for now must always pass in id - why? why not? possible tx without id???
    tx = Tx.new( from, to, qty, what, id )
    if @exchange.sufficient_tulips?( tx.from, tx.qty, tx.what ) && @exchange.add_transaction( tx )
      send_transaction_to_peers( tx )
      return true
    else
      return false
    end
  end

  def on_send( to, qty, what )
    tx = @wallet.generate_transaction( to, qty, what )
    if @exchange.sufficient_tulips?( tx.from, tx.qty, tx.what ) && @exchange.add_transaction( tx )
      send_transaction_to_peers( tx )
      return true
    else
      return false
    end
  end


  def on_mine!
    @exchange.mine_block!
    send_chain_to_peers
  end

  def on_resolve( data )
    chain_new = Blockchain.from_json( data )
    if @exchange.resolve!( chain_new )
      send_chain_to_peers
      return true
    else
      return false
    end
  end



private

  def send_chain_to_peers
    data = JSON.pretty_generate( @exchange.as_json )   ## payload in json
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
