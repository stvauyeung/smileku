class Ku < ActiveRecord::Base
	# So that the parent_id can be directly accessed in the siblings method
	attr_accessible :parent_id
	belongs_to :user
	belongs_to :story
	belongs_to :parent, class_name: 'Ku'
	has_many :children, class_name: 'Ku', foreign_key: 'parent_id'
	has_many :votes, as: :voteable
	has_many :comments
	validates :body, presence: true
	include Markdown

	def author_name
		self.user.username
	end

	def cover_preview
		self.story.large_cover.preview
	end

	def self.most_recent
  	last(7).reverse
  end

	def number_in_story
		# Use the 'pluck' method to minimize the amount of data you bring in.
		ku_ids = self.story.kus.order('created_at ASC').pluck(:id)
		position = ku_ids.index(self.id)
		number = position + 1
		number
	end

	def next_ku
		if self.children.present?
			find_top_voted(self.children.all)
		else
			nil
		end
	end

	def prev_ku
		# Minor nitpick - If parent.present? is false, nil is returned by default
		self.parent
	end

	def alt_ku
		if self.siblings.present?
			find_top_voted(self.siblings)
		else
			nil
		end
	end

	def vote_count
		self.votes.where(value: true).count - self.votes.where(value: false).count
	end

	def siblings
		if self.parent.present?
			# Cleaner way of generating the list. Also, reduces the number of queries to 2.
			self.parent.children.where('id IS DISTINCT FROM ?', id).all
		else
			nil
		end
	end

	def find_top_voted(kus)
		#Slightly cleaner way of finding the max element.
		# This would need to be optimized more to reduce the number of SQL queries if the number
		#   of Ku's gets to be too large (e.g. >10 on average)
		# Note: this change requires that kus be a ruby array, not a ActiveRecord relation.
		kus.max(&:vote_count)
	end
end
