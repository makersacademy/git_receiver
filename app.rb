require 'sinatra/base'

class GitReceiver < Sinatra::Base
  get '/' do
    'Hello GitReceiver!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
