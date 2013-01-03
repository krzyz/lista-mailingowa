require File.dirname(__FILE__) + '/spec_helper'
#require_relative '../app.rb'
require File.dirname(__FILE__) + '/../app'
#require Sinatra::Application.root + '/app'
disable :run

require 'capybara'
require 'capybara/dsl'

Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Capybara::DSL
end
