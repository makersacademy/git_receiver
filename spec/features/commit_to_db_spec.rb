require 'spec_helper'
require 'json'
require 'firebase'

describe 'committing data to a database' do
  include Rack::Test::Methods

  let(:database) { Firebase::Client.new('https://glaring-fire-9853.firebaseio.com/') }

  def app
    GitReceiver
  end

  it 'commits well-formed data to a database' do
    successful_commit = success_body.dup
    hsh = JSON.parse(successful_commit)
    expected_url = commit_url(hsh["remote_url"], hsh["commits"].first)
    make_post_request(successful_commit)
    expect(db('/commits').body.values.first["url"]).to eq expected_url
  end

  it 'errors if data is malformed' do
    expect { make_post_request(error_body).status }.to raise_error NoMethodError
  end

  private

  def make_post_request(body)
    post('/commits', body)
  end

  def error_body
    "{}"
  end

  def success_body
    "{\"email\": \"s_morgan@me.com\", \"commits\": [\"49f#{rand(99)}ce3e#{rand(99)}cb4b0b52b07ca#{rand(99)}b85de#{rand(999)}adb347\"], \"remote_url\": \"https://github.com/sjmog/rps-challenge.git\"}"
  end

  def db(path)
    database.get(path, query)
  end

  def commit_url(url, commit)
    "#{url.gsub(/\.git$/, '')}/commit/#{commit}"
  end

  def query
    {
      "orderBy" => '"created"',
      "limitToLast" => 1
    }
  end
end