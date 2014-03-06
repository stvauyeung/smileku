class AppMailer < ActionMailer::Base
	default from: 'contact@smileku.com'

	def welcome_email(user)
		@user = user
		mail(
			to: @user.email,
			subject: "Welcome to Smileku. So what's next?")
	end

	def password_reset_email(user)
		@user = user
		mail(
			to: @user.email,
			subject: "Your password reset instructions - Smileku")
	end

	def invite_email(user, invitee_name, invitee_email, message)
		@user = user
		@invitee_name = invitee_name
		@message = message
		mail(
			to: invitee_email,
			subject: "#{@invitee_name}, a friend on Smileku invites you to join")
	end

	def new_follower_email(followed, follower)
		@user = followed
		@follower = follower
		mail(
			to: @user.email,
			subject: "#{@follower.username} is now following you on Smileku!")
	end
end
