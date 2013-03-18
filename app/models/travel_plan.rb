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

class TravelPlan < ActiveRecord::Base
  attr_accessible :travel_group_id
  validates :user_id, presence: true
  has_many :travel_segments
  belongs_to :user
end
