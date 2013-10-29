class Ku < ActiveRecord::Base
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

	def self.most_recent
  	last(7).reverse
  end

	def number_in_story
		kus_in_story = self.story.kus.order('created_at ASC')
		position = kus_in_story.index(self)
		number = position + 1
		number
	end

	def next_ku
		if self.children.present?
			find_top_voted(self.children)
		else
			nil
		end
	end

	def prev_ku
		if self.parent.present?
			self.parent
		else
			nil
		end
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
			siblings = self.parent.children
			sibling_index = siblings.map { |e| e.id }
			sibling_index.delete(self.id)
			sibling_index.map!{ |i| Ku.find(i) }
		else
			nil
		end
	end

	def find_top_voted(kus)
		vote_hash = Hash[kus.map { |k| [k, k.vote_count] }]
		vote_hash.max_by{ |k, v| v}.first
	end
end