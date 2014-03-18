class StoryMailer < ActionMailer::Base
	default from: "\"Smileku\" <no-reply@smileku.com>"
	layout "layouts/app_mailer"

	def edit_ku_email(ku_id)
		@ku = Ku.find(ku_id)
		@user = @ku.user
		mail(
			to: @user.email,
			subject: "Time to edit your writing on '#{@ku.story.title}'")
		headers['X-Mailgun-Tag'] = "edit_reminder_email"
	end
end