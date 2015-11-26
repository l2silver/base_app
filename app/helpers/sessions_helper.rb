module SessionsHelper

	def logged_in?
		if session[:user_id]
			true
		else
			false
		end
	end

	def login(user_id)
		session[:user_id] = user_id
	end

	def current_user
		if session[:user_id]
			@current_user = User.find session[:user_id]
		else
			if (user_id = cookies.signed[:user_id])
				user = User.find(user_id)
				if user.authenticated?("remember", cookies.signed[:remember_token])
					login(user.id)
					@current_user = user
				end
			end
		end
		return @current_user
	end

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent.signed[:remember_token] = user.remember_token
	end

	def forget(user)
		user.forget
		session.delete(:user_id)
		if cookies.signed[:user_id]
			cookies.delete[:user_id]
			cookies.delete[:remember_token]
		end
	end

end
