
module EthQ


class Contract

  ## auto-add "well-known" methods for contract methods - why? why not?
  METHODS = {
    name: { inputs: [],
            outputs: ['string'] },
    symbol: { inputs: [],
              outputs: ['string'] },
    totalSupply: { inputs: [],
                   outputs: ['uint256'] },
  }


   METHODS.each do |name, m|
     eth = Ethlite::ContractMethod.new( name.to_s,
                                          inputs: m[:inputs],
                                          outputs: m[:outputs] )

      arity = m[:inputs].size
      if arity == 0
        define_method( name ) do
            args = []
            _do_call( eth, args )
        end
      elsif arity == 1
        define_method( name ) do |arg0|
          args = [arg0]
          _do_call( eth, args )
        end
      elsif arity == 2
        define_method( name ) do |arg0,arg1|
          args = [arg0, arg1]
          _do_call( eth, args )
        end
      else
         raise ArgumentError, "unsupported no. of arguments #{m[:inputs]} (arity); sorry"
      end
   end



  ## note: forward to Ethlite.config.rpc
  ##   keep config here as a convenience shortcut - why? why not?
  def self.rpc()        Ethlite.config.rpc; end
  def self.rpc=(value)  Ethlite.config.rpc = value; end




   def initialize( contract_address )
      @contract_address = contract_address
   end

######
#   private helper to call method
   def _do_call( eth, args )
     puts "  calling method >#{eth.name}< with args >#{args}<... "
     eth.do_call( self.class.rpc, @contract_address, args )
   end

end  # class Contract
end   # module EthQ
