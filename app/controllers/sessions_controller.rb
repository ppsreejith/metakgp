class SessionsController < ApplicationController
	
	def new
	end

	def create
		user = User.find_by_roll_no(params[:session][:roll_no].upcase)
    	if user && user.authenticate(params[:session][:password])
      		sign_in user
      		redirect_to profile_url
    	else
      		flash.now[:error] = 'Invalid roll number/password combination' 
      		render 'new'
    	end
  	end

	def destroy
		sign_out
		redirect_to root_url
	end

end
