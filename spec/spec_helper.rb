Dir['#{File.dirname(__FILE__)}/support/**/*.rb'].each {|file| require file}

require 'rubygems'
require 'bundler/setup'
require 'factory_girl'
require 'pry'
require 'matrix'
require 'ants' # Don't forget this...

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
