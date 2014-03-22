class Activity < ActiveRecord::Base
	belongs_to :subject, polymorphic: true
	belongs_to :user

	def self.most_recent(number)
		all.sort_by(&:created_at).last(10).reverse
	end
end