module Etherscan
  BASE = 'https://api.etherscan.io/api'


  def self.call( src )   ## get response as (parsed) json (hash table)

    headers = {
      # 'User-Agent' => "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36",
      'User-Agent' => "ruby v#{RUBY_VERSION}",
     }

    response = Webclient.get( src, headers: headers )

    if response.status.ok?
      puts "#{response.status.code} #{response.status.message} -  content_type: #{response.content_type}, content_length: #{response.content_length}"

      data = response.json

      ## note:  "unwrap" result - and auto-check status/message e.g.
      ##   {"status"=>"1",
      ##    "message"=>"OK",
      ##    "result"=>  ..
      ##    }
      ##
      ## An API call that encounters an error  will return 0 as its status code and display the cause of the error under the result field.
      ## {
      ##   "status":"0",
      ##   "message":"NOTOK",
      ##   "result":"Max rate limit reached, please use API Key for higher rate limit"
      ## }

      ##
      #  note: add special error handling case for no transaction found!!
      # ==> [8] query 0x01c59869B44F3Fc5420dbB9166a735CdC020E9Ae...
      # [debug] GET /api?module=account&action=txlist&address=...
      # 200 OK -  content_type: application/json, content_length: 172
      # !! ETHERSCAN API ERROR:
      # 0 No transactions found - []

      if data['status'] == '0' && data['message'] == 'No transactions found' && data['result'].empty?
        data['result']
      elsif data['status'] == '1' && data['message'] == 'OK'
        ## puts "#{data['status']} #{data['message']}"
        data['result']
      else
        puts "!! ETHERSCAN API ERROR:"
        puts "#{data['status']} #{data['message']} - #{data['result']}"
        exit 1
      end
    else
      puts "!! HTTP ERROR:"
      puts "#{response.status.code} #{response.status.message}"
      exit 1
    end
  end


  def self.proxy_call( src )   ## get response as (parsed) json (hash table)

    headers = {
      # 'User-Agent' => "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36",
      'User-Agent' => "ruby v#{RUBY_VERSION}",
     }

    response = Webclient.get( src, headers: headers )

    if response.status.ok?
      puts "#{response.status.code} #{response.status.message} -  content_type: #{response.content_type}, content_length: #{response.content_length}"

    ### check for {"jsonrpc"=>"2.0",
    ##  "id"=>1,
    ##   "result"=> ... }
      data = response.json
      ## pp data

      if data['result']
        data['result']
      elsif data['error']
        puts "!! ETHERSCAN API (PROXY JSON-RPC) ERROR:"
        puts "#{data['error']}"
        exit 1
      else
        puts "!! ETHERSCAN API (PROXY JSON-RPC) ERROR:"
        puts "  No response on request"
        exit 1
      end
    else
      puts "!! HTTP ERROR:"
      puts "#{response.status.code} #{response.status.message}"
      exit 1
    end
  end
end   # module Etherscan
