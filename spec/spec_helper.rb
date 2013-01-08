require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'sinatra'
require 'rack/test'
require 'rspec'
require 'capybara'

set :environment, :test
set :run, false

RSpec.configure do |config|
  config.before(:each) { DataMapper.auto_migrate! }
end
