
module Etherscan



  ###
  ##  eth_getTransactionByHash
  ##    Returns the information about a transaction requested
  ## by transaction hash.
  ##   see https://docs.etherscan.io/api-endpoints/geth-parity-proxy#eth_gettransactionbyhash

  def self.gettransactionbyhash_url( txhash: )
    src = "#{BASE}?module=proxy&action=eth_getTransactionByHash" +
          "&txhash=#{txhash}" +
          "&apikey=#{config.key}"
    src
  end

  def self.gettransactionbyhash( **kwargs )
    ## note: requires proxy_call!!! - different return / response format in json!!
    proxy_call( gettransactionbyhash_url( **kwargs ) )
  end

  #####
  ##  eth_getBlockByNumber
  ##    Returns information about a block by block number.
  ##      see https://docs.etherscan.io/api-endpoints/geth-parity-proxy#eth_getblockbynumber
  ##
  ##  the boolean value to show full transaction objects.
  ##     when true, returns full transaction objects and their information,
  ##     when false only returns a list of transactions.
  def self.getblockbynumber_url( blocknumber:, transactions: false )
    src = "#{BASE}?module=proxy&action=eth_getBlockByNumber" +
           "&tag=#{blocknumber}" +    ## note - must be a hexstring !!! e.g. 0x10d4f
           "&boolean=#{transactions}" +   ## " note:must be true or false
           "&apikey=#{config.key}"
    src
  end

  def self.getblockbynumber( **kwargs )
    ## note: requires proxy_call!!! - different return / response format in json!!
    proxy_call( getblockbynumber_url( **kwargs ) )
  end


end   # module Etherscan