require 'sinatra/base'
require 'json'
require 'firebase'
require 'dotenv'

Dotenv.load

class GitReceiver < Sinatra::Base
  post '/commits' do
    firebase = Firebase::Client.new(ENV['DATABASE_URL'])

    request.body.rewind
    data = request.body.read

    p "Received request: "
    p data

    hsh = JSON.parse(data.to_s)

    if matched_user = hsh["remote_url"].match(/github.com\/(.+)\//)
      user = matched_user[1]
    else
      user = hsh["remote_url"].match(/github\.com\:(.+)\//)[1]
    end

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
