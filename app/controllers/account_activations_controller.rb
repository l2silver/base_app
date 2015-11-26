class AccountActivationsController < ApplicationController
  def edit
  	@email = params[:email]
  	@activation_token = params[:id]
  	@user = User.find_by(email: @email)
	if @user
		if @user.authenticated?("activation", @activation_token)
			@user.update_attribute(:activated, true)
			login(@user.id)
			flash.clear()
			render("static_pages/logged_in")
		else
			flash[:warning] = "There was an error activating your account"
			render "static_pages/logged_out"
		end
	else
		render "static_pages/logged_out"
	end
  end
end