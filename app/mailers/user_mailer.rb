class UserMailer < ApplicationMailer
	 default from: 'no-reply@cvstom.org'
 
	  def account_activation(user)
	    @url  = edit_account_activation_url(user.activation_token, email: user.email)
	    mail(to: user.email, subject: 'Activate Your Account')
	  end
end
