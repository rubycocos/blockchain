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

  #####
  ##  Get Contract ABI for Verified Contract Source Codes
  ##   Returns the Contract Application Binary Interface ( ABI )
  ##   of a verified smart contract.
  ##      see https://docs.etherscan.io/api-endpoints/contracts#get-contract-abi-for-verified-contract-source-codes
  def self.getabi_url( address: )
    src = "#{BASE}?module=contract&action=getabi" +
            "&address=#{address}" +
            "&apikey=#{config.key}"
    src
  end

  def self.getabi( **kwargs )
    call( getabi_url( **kwargs ) )
  end

  #########
  ##  Get Contract Source Code for Verified Contract Source Codes
  ##  Returns the Solidity source code of a verified smart contract.
  ##    see https://docs.etherscan.io/api-endpoints/contracts#get-contract-source-code-for-verified-contract-source-codes
  def self.getsourcecode_url( address: )
    src = "#{BASE}?module=contract&action=getsourcecode" +
            "&address=#{address}" +
            "&apikey=#{config.key}"
    src
  end

  def self.getsourcecode( **kwargs )
    call( getsourcecode_url( **kwargs ) )
  end
end  # module Etherscan

