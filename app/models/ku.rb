class Ku < ActiveRecord::Base
	belongs_to :user
	belongs_to :story
	belongs_to :parent, class_name: 'Ku'
	has_many :children, class_name: 'Ku', foreign_key: 'parent_id'
	has_many :votes, as: :voteable
	has_many :comments
	has_many :activities, as: :subject
	validates :body, presence: true
	include Markdown
	extend FriendlyId
	friendly_id :url_format, use: :slugged

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
		ku_ids = self.story.kus.order('created_at ASC').pluck(:id)
		position = ku_ids.index(self.id)
		if position
			number = position + 1
		else
			number = ku_ids.size + 1
		end
		number
	end

	def strip_body
		ActionView::Base.full_sanitizer.sanitize(self.body)
	end

	def next_ku
		if self.children.present?
			find_top_voted(self.children)
		else
			nil
		end
	end

	def prev_ku
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

	# friendly_id methods
	def url_format
    "#{story.title} Ku #{number_in_story} by #{user.username}"
  end

  def should_generate_new_friendly_id?
  	new_record? || slug.blank?
  end
end