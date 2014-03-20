class ActivityWorker
	include Sidekiq::Worker

	def perform(subject_id, subject_type, action, user_id)
		Activity.create(
			subject_type: subject_type,
			subject_id: subject_id,
			action: action,
			user_id: user_id)
	end
end