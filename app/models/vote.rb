class Vote < ActiveRecord::Base
	belongs_to :ku
	belongs_to :user
	belongs_to :voteable, polymorphic: true
end