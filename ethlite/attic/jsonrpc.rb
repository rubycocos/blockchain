
###
#  simple JsonRpc client
#
#  see   https://www.jsonrpc.org/specification
#        https://en.wikipedia.org/wiki/JSON-RPC



class JsonRpc
      def initialize( uri )
        @uri       = URI.parse( uri )
        @client_id = Random.rand( 10000000 )
      end


      def request( method, params=[] )
        opts = {}
        if @uri.instance_of?( URI::HTTPS )
          opts[:use_ssl]     = true
          opts[:verify_mode] = OpenSSL::SSL::VERIFY_NONE
        end

        Net::HTTP.start( @uri.host, @uri.port, **opts ) do |http|
          headers = {"Content-Type" => "application/json"}
          request = Net::HTTP::Post.new( @uri.request_uri, headers )

          json = { jsonrpc: '2.0',
                   method:  method,
                   params:  params,
                   id: @client_id }.to_json

          puts "json POST payload:"
          puts json

          request.body = json
          response = http.request( request )

          unless response.kind_of?( Net::HTTPOK )
            raise "Error code #{response.code} on request #{@uri.to_s} #{request.body}"
          end


          body = JSON.parse( response.body, max_nesting: 1500 )

          if body['result']
            body['result']
          elsif body['error']
            raise "Error #{@uri.to_s} #{body['error']} on request #{@uri.to_s} #{request.body}"
          else
            raise "No response on request #{@uri.to_s} #{request.body}"
          end
        end
      end
end  # class JsonRpc

