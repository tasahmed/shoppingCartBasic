# Preview all emails at http://localhost:3000/rails/mailers/userregistration_mailer
class UserregistrationMailerPreview < ActionMailer::Preview

	def userregistration_preview
		UserregistrationMailer.userregistration_email(User.first, 'test')
	end
end
