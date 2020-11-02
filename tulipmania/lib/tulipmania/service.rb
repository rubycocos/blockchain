

module Tulipmania

class Service < Sinatra::Base

  def self.banner
    "tulipmania/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] on Sinatra/#{Sinatra::VERSION} (#{ENV['RACK_ENV']})"
  end


PUBLIC_FOLDER = "#{Tulipmania.root}/lib/tulipmania/public"
VIEWS_FOLDER  = "#{Tulipmania.root}/lib/tulipmania/views"

set :public_folder, PUBLIC_FOLDER # set up the static dir (with images/js/css inside)
set :views, VIEWS_FOLDER # set up the views dir

set :static, true # set up static file routing  -- check - still needed?


set connections: []


get '/style.css' do
  scss :style    ## note: converts (pre-processes) style.scss to style.css
end


get '/' do
  @node = node
  erb :index
end

post '/send' do
  node.on_send( params[:to], params[:qty].to_i, params[:what] )
  settings.connections.each { |out| out << "data: added transaction\n\n" }
  redirect '/'
end


post '/transactions' do
  if node.on_add_transaction(
    params[:from],
    params[:to],
    params[:qty].to_i,
    params[:what],
    params[:id]
  )
    settings.connections.each { |out| out << "data: added transaction\n\n" }
  end
  redirect '/'
end

post '/mine' do
  node.on_mine!
  redirect '/'
end

post '/peers' do
  node.on_add_peer( params[:host], params[:port].to_i )
  redirect '/'
end

post '/peers/:index/delete' do
  node.on_delete_peer( params[:index].to_i )
  redirect '/'
end



post '/resolve' do
  data = JSON.parse(request.body.read)
  if data['chain'] && node.on_resolve( data['chain'] )
    status 202     ### 202 Accepted; see httpstatuses.com/202
    settings.connections.each { |out| out << "data: resolved\n\n" }
  else
    status 200    ### 200 OK
  end
end


get '/events', provides: 'text/event-stream' do
  stream :keep_open do |out|
    settings.connections << out
    out.callback { settings.connections.delete(out) }
  end
end

private

#########
## return network node (built and configured on first use)
##   fix: do NOT use @@ - use a class level method or something
def node
  if defined?( @@node )
    @@node
  else
    puts "[debug] tulipmania - build (network) node (address: #{Tulipmania.config.address})"
    @@node = Node.new( address: Tulipmania.config.address )
    @@node
  end
  ####
  ## check why this is a syntax error:
  ## @node ||= do
  ##   puts "[debug] tulipmania - build (network) node (address: #{Tulipmania.config.address})"
  ##   @node = Node.new( address: Tulipmania.config.address )
  ## end
end


############
## helpers

def fmt_tulips( hash )
   lines = []
   hash.each do |what,qty|
     lines << "#{what} × #{qty}"
   end
   lines.join( ', ' )
end

end # class Service
end # module Tulipmania
