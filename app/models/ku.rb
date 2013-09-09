class Ku < ActiveRecord::Base
	belongs_to :user
	belongs_to :story
	belongs_to :parent, class_name: 'Ku'
	has_many :children, class_name: 'Ku', foreign_key: 'parent_id'
	validates :body, presence: true
end