
###
#  simple JsonRpc client
#
#  see   https://www.jsonrpc.org/specification
#        https://en.wikipedia.org/wiki/JSON-RPC



class JsonRpc

      ### add a global debug switch - why? why not?
      def self.debug?()  (@debug || false) == true; end
      def self.debug( value ) @debug = value; end
      ####
      # private helpers
      def debug?()  self.class.debug?;  end



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

          if debug?
            puts "json_rpc POST payload:"
            puts data.to_json
          end

          response = Webclient.post( @uri, json: data )


          if response.status.nok?
            raise "Error code #{response.status.code} on request #{@uri} #{data}"
          end

          if debug?
            puts "json_rpc response.body:"
            puts response.body
          end


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

