Fabricator(:story) do
	title { Faker::Lorem.words(5).join(' ') }
	description { Faker::Lorem.sentences(2).join(' ') }
	user_id { Fabricate(:user).id }
	# large_cover { File.open("public/tmp/mrec1.jpg", "w") }
	after_build { |story| story.large_cover = File.open("public/tmp/cat1.png") }
	after_create { |story| Fabricate(:ku, user_id: story.user_id, story_id: story.id)}
end

Fabricator(:invalid_story, from: :story) do
	title { nil }
end