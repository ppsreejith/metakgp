# == Schema Information
#
# Table name: travel_plans
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe TravelPlan do

	let (:user) { FactoryGirl.create(:user) }
	before do 
		@tplan = user.travel_plans.build()
	end
	
	subject { @tplan }

	it { should respond_to(:user_id) }
	it { should respond_to(:travel_group_id) }

	it { should be_valid }

	describe "when user_id is not present" do
    	before { @tplan.user_id = nil }
    	it { should_not be_valid }
  	end
	
	describe "accessible attributes" do
    	it "should not allow access to user_id" do
    		expect do
        		TravelPlan.new(user_id: user.id)
      		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    	end
    end
end
