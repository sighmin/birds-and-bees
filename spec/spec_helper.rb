require 'rubygems'
require 'bundler/setup'
require 'factory_girl'
# our gem
require 'ants'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
