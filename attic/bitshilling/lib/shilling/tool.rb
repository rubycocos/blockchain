# encoding: utf-8


module Shilling

class Tool

def run( args )
  opts = {}

  parser = OptionParser.new do |cmd|
    cmd.banner = "Usage: shilling [options]"

    cmd.separator ""
    cmd.separator "  Wallet options:"

    cmd.on("-n", "--name=NAME", "Address name (default: Theresa)") do |name|
      ## use -a or --adr or --address as option flag - why? why not?
      ##  note: default now picks a random address from WALLET_ADDRESSES
      opts[:address] = name
    end


    cmd.separator ""
    cmd.separator "  Server (node) options:"

    cmd.on("-o", "--host HOST", "listen on HOST (default: 0.0.0.0)") do |host|
      opts[:Host] = host    ## note: rack server handler expects :Host
    end

    cmd.on("-p", "--port PORT", "use PORT (default: 4567)") do |port|
      opts[:Port] = port    ## note: rack server handler expects :Post
    end

    cmd.on("-h", "--help", "Prints this help") do
      puts cmd
      exit
    end
  end

  parser.parse!( args )
  pp opts


  ###################
  ## startup server (via rack interface/handler)

  app_class = Service    ##  use  app = Service.new  -- why? why not?
  host = opts[:Host] || '0.0.0.0'
  port = opts[:Port] || '4567'

  Shilling.configure do |config|
    config.address = opts[:address] || 'Theresa'
  end

  Rack::Handler::WEBrick.run( app_class, Host: host, Port: port ) do |server|
      ## todo: add traps here - why, why not??
  end


end  ## method run


end   ## class Tool

end   ## module Shilling
