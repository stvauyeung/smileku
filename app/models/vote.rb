class Vote < ActiveRecord::Base
	belongs_to :ku
	belongs_to :user
	belongs_to :voteable, polymorphic: true

	def self.for_ku(ku, user, value)
		if ku.votes.where(user_id: user.id).exists?
			handle_existing_vote(ku, user, value)
		else
			Vote.create(value: value, voteable_type: "Ku", voteable_id: ku.id, user_id: user.id)
		end
	end

	def self.handle_existing_vote(ku, user, value)
		vote = ku.votes.where(user_id: user.id).first
		if vote.value.to_s == value
			vote.destroy
		else
			vote.update_attributes(value: value)
		end
	end
end