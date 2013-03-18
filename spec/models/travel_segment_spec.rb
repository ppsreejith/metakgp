# == Schema Information
#
# Table name: travel_segments
#
#  id         :integer          not null, primary key
#  from       :string(255)
#  to         :string(255)
#  at         :datetime
#  plan_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe TravelSegment do

	let (:user) { FactoryGirl.create(:user) }
	before do
		@tplan = user.travel_plans.build()
		@tplan.save 
		@tseg = @tplan.travel_segments.build(from: "Kgp", to: "New Delhi", at: DateTime.new(2013, 1, 6))
	end

	subject { @tseg }

	it { should respond_to(:from) }
	it { should respond_to(:to) }
	it { should respond_to(:at) }
  	it { should respond_to(:travel_plan_id) }
  	its(:travel_plan) { should == @tplan }

  	it { should be_valid }

  	describe "when travel_plan_id is not present" do
    	before { @tseg.travel_plan_id = nil }
    	it { should_not be_valid }
  	end

  	describe "when address format is invalid" do
    	it "should be invalid" do
      		addresses = ['kerala13', '43342', '%gids',
                     '(fsdfsd)', 'dvsd_fff', 'ahmedabad', 'Monte  Carlos', ' heap']
      		addresses.each do |invalid_address|
        		@tseg.from = invalid_address
        		@tseg.should_not be_valid
      		end
      	end      
    end

    describe "when address format is valid" do
    	it "should be valid" do
      		addresses = ['Kerala', 'Peres', 'Sri Nagar']
      		addresses.each do |invalid_address|
        		@tseg.from = invalid_address
        		@tseg.should be_valid
      		end
      	end      
    end
  
	describe "accessible attributes" do
    it "should not allow access to plan_id" do
    	expect do
        	TravelSegment.new(travel_plan_id: @tplan.id)
      	end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
