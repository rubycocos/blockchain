  module Ethlite
      class ContractMethod


        attr_reader :signature,
                    :name,
                    :signature_hash,
                    :input_types,
                    :output_types,
                    :constant

        def initialize( name, inputs:   [],
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
                                           ABI.encode(@input_types, args) )

          method = 'eth_call'
          params = [{ to:   contract_address,
                      data: data},
                    'latest']
          response = rpc.request( method, params )

          if debug?
            puts "response:"
            pp response
          end

          bin = Utils.decode_hex( response )
          return nil    if bin.empty?

          result = ABI.decode( @output_types, bin )


          if debug?
            puts
            puts "result decode_abi:"
            pp result
          end

          result.length==1 ? result.first : result
        end

        ####
        # private helpers
        def debug?()  Ethlite.debug?;  end   ## forward to global Ethlite config
      end  # class ContractMethod

end  # module Ethlite

