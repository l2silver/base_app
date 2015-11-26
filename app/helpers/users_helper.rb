module UsersHelper
	def user_email_exists?(email)
		if User.find_by(email: email.downcase)
			return true
		else
			return false
		end
	end
end
