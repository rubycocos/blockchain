
class ContractMethod

  def self.parse_abi( abi )
    ## convenience helper -  auto-convert to json if string passed in
    abi = JSON.parse( abi ) if abi.is_a?( String )

    name           = abi['name']
    constant       = !!abi['constant'] || abi['stateMutability']=='view'
    input_types    = abi['inputs']  ? abi['inputs'].map{|a| _parse_component_type( a ) } : []
    output_types   = abi['outputs'] ? abi['outputs'].map{|a| _parse_component_type( a ) } : []

    new( name, inputs: input_types,
               outputs: output_types,
               constant: constant )
  end

  def self._parse_component_type( argument )
   if argument['type'] =~ /^tuple((\[[0-9]*\])*)/
     argument['components'] ? "(#{argument['components'].collect{ |c| _parse_component_type( c ) }.join(',')})#{$1}"
                            : "()#{$1}"
   else
     argument['type']
   end
  end

end   # class ContractMethod
