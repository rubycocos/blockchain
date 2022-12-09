
###
#  simple JsonRpc client
#
#  see   https://www.jsonrpc.org/specification
#        https://en.wikipedia.org/wiki/JSON-RPC



class JsonRpc
      def initialize( uri )
        @uri        = uri    ## assume uri always as string for now
        @request_id = 1
      end


      def request( method, params=[] )

          data = { jsonrpc: '2.0',
                   method:  method,
                   params:  params,
                   id: @request_id }

          @request_id += 1

          puts "json_rpc POST payload:"
          puts data.to_json

          response = Webclient.post( @uri, json: data )


          if response.status.nok?
            raise "Error code #{response.status.code} on request #{@uri} #{data}"
          end

          puts "json_rpc response.body:"
          puts response.body


          body = JSON.parse( response.body, max_nesting: 1500 )

          if body['result']
            body['result']
          elsif body['error']
            raise "Error #{@uri} #{body['error']} on request #{@uri} #{data}"
          else
            raise "No response on request #{@uri} #{data}"
          end
      end  # method request
end  # class JsonRpc

