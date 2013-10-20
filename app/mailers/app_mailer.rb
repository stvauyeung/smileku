class AppMailer < ActionMailer::Base
	default from: 'contact@smileku.com'

	def welcome_email(user)
		@user = user
		mail(
			to: @user.email,
			subject: "Welcome to Smileku. So what's next?")
	end
end
