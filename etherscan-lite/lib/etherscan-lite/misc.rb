
module Etherscan


###############
#  all-in-one helper for getting contract details
#    note: requires (collects data via) three api calls

def self.getcontractdetails( contractaddress: )

  delay_in_s = 0.5
  puts "   sleeping #{delay_in_s} sec(s)..."
  sleep( delay_in_s )
  data = getcontractcreation( contractaddresses: [contractaddress] )
  ## pp data

  # [{"contractAddress"=>"0x16f5a35647d6f03d5d3da7b35409d65ba03af3b2",
  #   "contractCreator"=>"0xc352b534e8b987e036a93539fd6897f53488e56a",
  #   "txHash"=>"0xc82aa34310c310463eb9fe7835471f7317ac4b5008034a78c93b2a8a237be228"}]

  ## reuse hash from repsone - why? why not?
  details = data[0]

  puts "   sleeping #{delay_in_s} sec(s)..."
  sleep( delay_in_s )
  data2 = gettransactionbyhash( txhash: details['txHash'] )
  ## puts
  ## pp data2
  #  {"blockHash"=>"0x07f9b4846ee2702da8d18b9eeead15912d977acc8886ab9bf5d760914cb37670",
  #  "blockNumber"=>"0x3f17d2",
  # "from"=>"0xa97f8ffc8f8e354475880448334e4e99a0e7212f",
  #  "gas"=>"0x2c51d3",
  # "gasPrice"=>"0x53c53dc33",
  # "hash"=>"0x79d48c41b99f0ac8f735dbf4d048165542576862df2b05a80be9a4dbe233a623",
  details['blockNumber']  = data2['blockNumber']

  puts "   sleeping #{delay_in_s} sec(s)..."
  sleep( delay_in_s )
  data3 = getblockbynumber( blocknumber: data2['blockNumber'] )
  ## puts
  ## pp data3

  details['timestamp'] = data3['timestamp']
  details
end


end  # module Etherscan