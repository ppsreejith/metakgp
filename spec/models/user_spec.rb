# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  roll_no    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example", email: "foo@bar.com", roll_no: "11XY30089", 
  	password: 'foobar', password_confirmation: 'foobar')}
  subject { @user }
  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:roll_no)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate)}
  it { should be_valid }

  describe "name is absent" do
  	before { @user.name = ' ' }
  	it { should_not be_valid }
  end

  describe "email is absent" do
  	before { @user.email = ' ' }
  	it { should_not be_valid }
  end

  describe "roll number is absent" do
  	before { @user.roll_no = ' ' }
  	it { should_not be_valid }
  end

  describe "when password is absent" do
  	before { @user.password = @user.password_confirmation = " " }
  	it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
  	before { @user.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
  	before { @user.password_confirmation = nil }
  	it { should_not be_valid }
  end

  describe "return value of authenticate method" do
  	before { @user.save }
  	let(:found_user) { User.find_by_email(@user.email) }

  	describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
  	end

  	describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
  	end
  end

  describe "when name is too long" do
  	before { @user.name = 'a' * 51 }
  	it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "when roll_no is invalid" do
  	it "should be invalid" do
  	  roll_nos = %w[1234PY58867 34233Y 11C3442 23CHH40065]
  	  roll_nos.each do |invalid_roll_no|
  	  	@user.roll_no = invalid_roll_no
  	  	@user.should_not be_valid
  	  end
  	end
  end

  describe "when roll_no is valid" do
  	it "should be valid" do
  	  roll_nos = %w[12PY588 9CY3245 11CS3442 23HH40065]
  	  roll_nos.each do |valid_roll_no|
  	  	@user.roll_no = valid_roll_no
  	  	@user.should be_valid
  	  end
  	end
  end

  describe "when email address / roll_no is already taken" do
    before do
      same_user = @user.dup
      same_user.email.upcase!
      same_user.roll_no.upcase!
      same_user.save
    end
    it { should_not be_valid }
  end

end
