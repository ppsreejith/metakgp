# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  roll_no         :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :roll_no, :password, :password_confirmation
  has_secure_password
  before_save do |user|
  	user.email.downcase!
  	user.roll_no.upcase!  
  end
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  VALID_ROLL_NO_REGEX = /\A\d{1,2}[A-Z]{2}\d{3,5}\z/
  validates :roll_no, presence: true, format: { with: VALID_ROLL_NO_REGEX }, uniqueness: { case_sensitive: false }

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
