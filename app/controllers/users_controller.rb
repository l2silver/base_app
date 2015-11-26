class UsersController < ApplicationController
  include UsersHelper

  def check_email
  	if user_email_exists?(params[:email])
  		render json: {response: true}
  	else
  		render json: {response: false}
  	end
  end

  def create
  	@user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password])
  	if @user
      UserMailer.account_activation(@user).deliver_now
  		flash[:success] = "Account successfully created. Please check your email for the confirmation link to continue"
  	else
  		flash[:warning] = "There was an error creating your account"
  	end
  	render "static_pages/logged_out"
  end
end
