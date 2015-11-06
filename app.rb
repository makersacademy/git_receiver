require 'sinatra/base'
require 'json'

class GitReceiver < Sinatra::Base
  post '/commits' do
    request.body.rewind
    data = request.body.read
    hsh = JSON.parse(data.to_s)

    user = hsh["remote_url"].match(/github.com\/(.+)\//)[1]
    email = hsh["email"]
    url = hsh["remote_url"]
    commits = hsh["commits"]

    p "User: #{user}"
    p "Email: #{email}"

    commits.each do | commit |
      p "Commit URL: #{url.gsub(/\.git$/, '')}/commit/#{commit}"
    end
    
    200
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
