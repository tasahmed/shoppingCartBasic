class UserregistrationMailer < ApplicationMailer
	
	default from: "donotreply@shoppingneeds.com"

	def userregistration_email(user, pwd)
		@user = user
		@pwd  = pwd
		@response = mail(to: @user.email, subject: 'Registration Mail')
		logger.debug "Mail response: #{@response}"
	end
end
