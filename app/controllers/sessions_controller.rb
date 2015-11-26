class SessionsController < ApplicationController
 skip_before_action :verify_authenticity_token


	def create
		@email = params[:session][:email]
		@password = params[:session][:password]
		@remember = params[:session][:remember]
		@user = User.find_by(email: @email)
		if @user
			if @user.authenticated?("password", @password)
				login(@user.id)
				remember @user if @remember
				flash.clear
				render "static_pages/logged_in"
			else
				flash[:warning] = "Email and password combination is incorrect"
				render "static_pages/logged_out"
			end
		else
			flash[:warning] = "Email does not exist"
			render "static_pages/logged_out"
		end
	end

	def destroy
		forget current_user
		render "static_pages/logged_out"
	end



end
