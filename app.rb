require 'sinatra/base'

class GitReceiver < Sinatra::Base
  post '/commits' do
    "Hello World"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
