module Etherscan
  BASE = 'https://api.etherscan.io/api'




  def self.call( src )   ## get response as (parsed) json (hash table)
    uri = URI.parse( src )

    http = Net::HTTP.new( uri.host, uri.port )

    puts "[debug] GET #{uri.request_uri} uri=#{uri}"

    headers = {
      # 'User-Agent' => "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36",
      'User-Agent' => "ruby v#{RUBY_VERSION}",
     }


    request = Net::HTTP::Get.new( uri.request_uri, headers )
    if uri.instance_of? URI::HTTPS
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    response   = http.request( request )

    if response.code == '200'
      puts "#{response.code} #{response.message} -  content_type: #{response.content_type}, content_length: #{response.content_length}"

      text = response.body.to_s
      text = text.force_encoding( Encoding::UTF_8 )

      data = JSON.parse( text )
      data

      ## note:  "unwrap" result - and auto-check status/message e.g.
      ##   {"status"=>"1",
      ##    "message"=>"OK",
      ##    "result"=>  ..
      ##    }
      if data['status'] == '1' && data['message'] == 'OK'
         puts "#{data['status']} #{data['message']}"
         data['result']
      else
        puts "!! ETHERSCAN API ERROR:"
        puts "#{data['status']} #{data['message']}"
        exit 1
      end
    else
      puts "!! ERROR:"
      puts "#{response.code} #{response.message}"
      exit 1
    end
  end

end   # module Etherscan
