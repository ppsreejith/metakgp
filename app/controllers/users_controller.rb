class UsersController < ApplicationController

  before_filter :must_be_signed_in, only: [:show]
  before_filter :redirect_if_already_signed_in, only: [:new, :create]

  def new
  	@user = User.new
  end

  def show
    	@user = current_user
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  	  flash[:success] = 'Welcome to metakgp!'
  	  redirect_to @user
  	else
  	  render 'new'
  	end
  end

  

end
