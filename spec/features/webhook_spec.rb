require 'spec_helper'

describe 'receiving data on the webhook' do
  include Rack::Test::Methods

  def app
    GitReceiver
  end

  context 'with well-formed data' do
    it 'succeeds with https addresses' do
      expect(make_post_request(success_body).status).to eq 200
    end

    it 'succeeds with git@ addresses' do
      expect(make_post_request(alt_success_body).status).to eq 200
    end
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
    "{\"email\": \"s_morgan@me.com\", \"commits\": [\"49f23ce3e34cb4b0b52b07ca27b85de753adb347\"], \"remote_url\": \"https://github.com/sjmog/rps-challenge.git\"}"
  end

  def alt_success_body
    "{\"email\": \"s_morgan@me.com\", \"commits\": [\"49f23ce3e34cb4b0b52b07ca27b85de753adb347\"], \"remote_url\": \"git@github.com:sjmog/rps-challenge.git\"}"
  end
end