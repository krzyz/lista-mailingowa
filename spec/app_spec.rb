# encoding: UTF-8
require File.dirname(__FILE__) + '/acceptance_helper'

describe 'App' do
  include Rack::Test::Methods

  #def app
  #  Index.new
  #end
  #
  #

  it 'should not give admin page unless logged' do
    visit '/admin'
    page.should_not have_content "Zmień"
    page.should have_content "Nazwa"
  end

end
