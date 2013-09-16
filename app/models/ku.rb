class Ku < ActiveRecord::Base
	belongs_to :user
	belongs_to :story
	belongs_to :parent, class_name: 'Ku'
	has_many :children, class_name: 'Ku', foreign_key: 'parent_id'
	validates :body, presence: true

	def author_name
		self.user.username
	end

	def number_in_story
		position = self.story.kus.index(self)
		number = position + 1
		"KU##{number}"
	end

	def next_ku
		if self.children.present?
			self.children.first
		elsif self.parent.nil?
			nil
		elsif self.parent.children.size > 1
			siblings = self.parent.children
			sibling_index = siblings.map { |e| e.id }
			sibling_index.delete(self.id)
			Ku.find(sibling_index.sample)
		elsif self.parent.parent.children.size > 1
			parent_siblings = self.parent.parent.children
			parent_sibling_index = parent_siblings.map { |e| e.id }
			parent_sibling_index.delete(self.parent.id)
			Ku.find(parent_sibling_index.sample)
		end
	end

	def skip_ku
		
	end
end