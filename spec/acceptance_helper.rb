require File.dirname(__FILE__) + '/spec_helper'
require Index.root + '/app'

require 'capybara'
require 'capybara/dsl'

Capybara.app = Index.new

RSpec.configure do |config|
  config.include Capybara::DSL
end
