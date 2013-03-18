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

class TravelSegment < ActiveRecord::Base
  attr_accessible :at, :from, :to
  validates :at, presence: true
  VALID_ADDRESS_REGEX = /\A[A-Z][a-z]*( [A-Z][a-z]*)*\z/
  validates :from, presence: true, format: { with: VALID_ADDRESS_REGEX }
  validates :to, presence: true, format: { with: VALID_ADDRESS_REGEX }
  validates :travel_plan_id, presence: true
  
  belongs_to :travel_plan 
end
