class AppMailer < ActionMailer::Base
	default from: "\"Smileku\" <contact@smileku.com>"

	def welcome_email(user)
		@user = user
		mail(
			to: @user.email,
			subject: "Welcome to Smileku. So what's next?")
		headers['X-Mailgun-Tag'] = "welcome_email"
	end

	def password_reset_email(user)
		@user = user
		mail(
			to: @user.email,
			subject: "Your password reset instructions - Smileku")
		headers['X-Mailgun-Tag'] = "password_reset_email"
	end

	def invite_email(user, invitee_name, invitee_email, message)
		@user = user
		@invitee_name = invitee_name
		@message = message
		mail(
			to: invitee_email,
			subject: "#{@invitee_name}, you've been invited to join our writing community")
		headers['X-Mailgun-Tag'] = "invite_email"
	end

	def new_follower_email(followed, follower)
		@user = followed
		@follower = follower
		mail(
			to: @user.email,
			subject: "#{@follower.username} is now following you on Smileku!"
			)
		headers['X-Mailgun-Tag'] = "new_follower_email"
	end
end
