require 'sinatra/base'
require 'json'

class GitReceiver < Sinatra::Base
  post '/commits' do
    request.body.rewind
    p JSON.parse(request.body.read)
    200
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
