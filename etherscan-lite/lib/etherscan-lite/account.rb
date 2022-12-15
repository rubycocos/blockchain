module Etherscan

  ##  Get a list of 'Normal' Transactions By Address
  ##    Returns the list of transactions performed by an address,
  ##     with optional pagination.
  ## see https://docs.etherscan.io/api-endpoints/accounts#get-a-list-of-normal-transactions-by-address
  def self.txlist_url( address:,
                       startblock: 0,
                       endblock: 99999999,
                       page: 1,
                       offset: 10,
                       sort: 'desc' )

    src = "#{BASE}?module=account&action=txlist" +
           "&address=#{address}" +
           "&startblock=#{startblock}" +
           "&endblock=#{endblock}" +
           "&page=#{page}" +
           "&offset=#{offset}" +
           "&sort=#{sort}" +
           "&apikey=#{config.key}"
    src
  end

  def self.txlist( **kwargs )
     call( txlist_url( **kwargs ) )
  end


  ## Get a list of 'ERC20 - Token Transfer Events' by Address
  ##  Returns the list of ERC-20 tokens transferred by an address,
  ##      with optional filtering by token contract.
  ##  Usage:
  ##  - ERC-20 transfers from an address, specify the address parameter
  ##  - ERC-20 transfers from a contract address, specify the contract address parameter
  ##  - ERC-20 transfers from an address filtered by a token contract, specify both address and contract address parameters.
  ##
  ## see https://docs.etherscan.io/api-endpoints/accounts#get-a-list-of-erc20-token-transfer-events-by-address
  def self.tokentx_url( address: nil,
                        contractaddress: nil,
                       startblock: 0,
                       endblock: 99999999,
                       page: 1,
                       offset: 10,
                       sort: 'desc' )

    src = "#{BASE}?module=account&action=tokentx" +
           "&startblock=#{startblock}" +
           "&endblock=#{endblock}" +
           "&page=#{page}" +
           "&offset=#{offset}" +
           "&sort=#{sort}" +
           "&apikey=#{config.key}"

    ## optional
    src +=  "&address=#{address}"                   if address
    src +=  "&contractaddress=#{contractaddress}"   if contractaddress
    src
  end

  def self.tokentx( **kwargs )
    call( tokentx_url( **kwargs ) )
  end


  ## Get a list of 'ERC721 - Token Transfer Events' by Address
  ##  Returns the list of ERC-721 ( NFT ) tokens transferred by an address,
  ##    with optional filtering by token contract.
  ##  Usage:
  ##  - ERC-721 transfers from an address, specify the address parameter
  ##  - ERC-721 transfers from a contract address, specify the contract address parameter
  ##  - ERC-721 transfers from an address filtered by a token contract, specify both address and contract address parameters.
  ##
  ## see https://docs.etherscan.io/api-endpoints/accounts#get-a-list-of-erc721-token-transfer-events-by-address
  def self.tokennfttx_url( address: nil,
                           contractaddress: nil,
                           startblock: 0,
                           endblock: 99999999,
                           page: 1,
                           offset: 10,
                           sort: 'desc' )

    src = "#{BASE}?module=account&action=tokennfttx" +
          "&startblock=#{startblock}" +
          "&endblock=#{endblock}" +
          "&page=#{page}" +
          "&offset=#{offset}" +
          "&sort=#{sort}" +
          "&apikey=#{config.key}"

    ## optional
    src +=  "&address=#{address}"                   if address
    src +=  "&contractaddress=#{contractaddress}"   if contractaddress
    src
  end

  def self.tokennfttx( **kwargs )
    call( tokennfttx_url( **kwargs ) )
  end
end # module Etherscan
