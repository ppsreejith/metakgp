require 'spec_helper'

describe "TravelPages" do
  
  subject { page }

  describe "create a travel segment" do

  	describe "not signed in" do
  		before { visit new_travel_path}
  		it { should have_selector("h1", text: "Sign in")}
  	end

  	describe "signed in" do
	  	let(:user) { FactoryGirl.create(:user) }
  		before do   		
  			sign_in(user)
	  		visit new_travel_path	
  		end
	    it { should have_selector("h1", text: "Make a travel plan") }
	end

  end

end
