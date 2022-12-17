module Etherscan


  ###
  ## Get Contract Creator and Creation Tx Hash
  ##   Returns a contract's deployer address and transaction hash
  ## it was created, up to 5 at a time.
  ##   see https://docs.etherscan.io/api-endpoints/contracts#get-contract-creator-and-creation-tx-hash
  def self.getcontractcreation_url( contractaddresses: )
    src = "#{BASE}?module=contract&action=getcontractcreation" +
            "&contractaddresses=#{contractaddresses.join(',')}" +
            "&apikey=#{config.key}"
    src
  end

  def self.getcontractcreation( **kwargs )
    call( getcontractcreation_url( **kwargs ) )
  end


end  # module Etherscan