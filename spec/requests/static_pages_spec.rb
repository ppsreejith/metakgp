require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "home page" do
  	before { visit root_path }
    it {should have_selector('title', text: 'Metakgp | Travel')}
    it {should have_content 'Sign up'}
    it {should have_selector('footer')}   
  end
end
