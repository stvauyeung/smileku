class StoryMailer < ActionMailer::Base
	default from: "no-reply@smileku.com"
	layout "layouts/app_mailer"

	def edit_ku_email(ku_id)
		@ku = Ku.find(ku_id)
		@user = @ku.user
		mail(
			to: @user.email,
			subject: "[Smileku] Edit your addition to '#{@ku.story.title}'",
			headers: 'X-Mailgun-Variable: {"tag": "edit_reminder_email"}}')
	end
end