require 'spec_helper'

describe 'receiving data on the webhook' do
  include Rack::Test::Methods

  def app
    GitReceiver
  end

  it 'receives data' do
    expect(sample_post_request.body).to eq "Hello World"
  end

  def sample_post_request
    post('/commits', {})
  end
end