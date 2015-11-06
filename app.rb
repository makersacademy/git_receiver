require 'sinatra/base'
require 'json'
require 'firebase'

class GitReceiver < Sinatra::Base
  post '/commits' do
    firebase = Firebase::Client.new("https://glaring-fire-9853.firebaseio.com/")

    request.body.rewind
    data = request.body.read
    hsh = JSON.parse(data.to_s)

    user = hsh["remote_url"].match(/github.com\/(.+)\//)[1]
    email = hsh["email"]
    url = hsh["remote_url"]
    commits = hsh["commits"]

    commits.each do | commit |
      commit_url = "#{url.gsub(/\.git$/, '')}/commit/#{commit}"
      firebase.push("commits", { :user => user, :url => commit_url, :created => Firebase::ServerValue::TIMESTAMP })
    end

    200
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
