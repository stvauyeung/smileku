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
			find_siblings(self)
		else
			self.parent.skip_ku
		end
	end

	def skip_ku
		if self.parent.nil?
			nil
		elsif	self.parent.children.size > 1
			find_siblings(self)
		else
			self.parent.skip_ku
		end
	end

	def random_ku
		kus_in_story = self.story.kus
		kus_index = kus_in_story.map { |e| e.id }
		kus_index.delete(self.id)
		Ku.find(kus_index.sample)
	end

	private

	def find_siblings(ku)
		siblings = ku.parent.children
		sibling_index = siblings.map { |e| e.id }
		sibling_index.delete(ku.id)
		Ku.find(sibling_index.sample)
	end
end