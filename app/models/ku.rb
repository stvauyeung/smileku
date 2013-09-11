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
end