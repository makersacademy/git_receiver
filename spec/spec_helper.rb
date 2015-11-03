ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'rspec'
require 'rack/test'
require 'capybara'
require 'capybara/rspec'
require 'capybara/json'

Capybara.app = GitReceiver

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::Json

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
