class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  		render "logged_in"
  	else
  		render "logged_out"
  	end
  end
end
