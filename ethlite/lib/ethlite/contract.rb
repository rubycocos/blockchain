  module Ethlite
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



        attr_reader :signature,
                    :name,
                    :signature_hash,
                    :input_types,
                    :output_types,
                    :constant

        def initialize( name, inputs:,
                              outputs:  [],
                              constant: true )
          @name         = name
          @constant     = constant

          ##  parse inputs & outputs into types
          @input_types  = inputs.map { |str| ABI::Type.parse( str ) }
          @output_types = outputs.map { |str| ABI::Type.parse( str ) }

          types = @input_types.map {|type| type.format }.join(',')
          @signature      = "#{@name}(#{types})"
          @signature_hash = Utils.encode_hex( Utils.keccak256( @signature)[0,4] )
        end


        def do_call( rpc, contract_address, args )
          data = '0x' + @signature_hash + Utils.encode_hex(
                                           Abi.encode_abi(@input_types, args) )

          method = 'eth_call'
          params = [{ to:   contract_address,
                      data: data},
                    'latest']
          response = rpc.request( method, params )


          puts "response:"
          pp response

          string_data = Utils.decode_hex(
                           Utils.remove_0x_head(response))
          return nil if string_data.empty?

          result = Abi.decode_abi( @output_types, string_data )
          puts
          puts "result decode_abi:"
          pp result


          result.length==1 ? result.first : result
        end

      end  # class ContractMethod
end  # module Ethlite

