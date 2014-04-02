# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times { Fabricate(:user) }

User.all.each do |u|
	Fabricate(:story, user_id: u.id)
end 

10.times { Fabricate(:ku, story_id: rand(1..5), user_id: rand(1..5)) }

Story.all.each do |s|
	Activity.create(subject_id: s.id, subject_type: 'Story', action: 'created_story', user_id: s.user_id)
end

Ku.all.each do |k|
	Activity.create(subject_id: k.id, subject_type: 'Ku', action: 'created_ku', user_id: k.user_id)
end