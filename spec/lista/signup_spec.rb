# encoding: utf-8

require_relative '../lista_helper.rb'


describe 'Pages' do

  subject { page }

  describe 'signup page' do
    before { visit '/' }

    it { should have_selector('title', text: 'Lista mailingowa NKF') }
  end
end
