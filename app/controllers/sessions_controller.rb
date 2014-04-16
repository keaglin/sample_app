class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			sign_in user
			redirect_to user, :notice => 'Logged in!'
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		session[:user_id] = nil
		redirect_to root_url, :notice => 'Logged out!'
	end
	
end
