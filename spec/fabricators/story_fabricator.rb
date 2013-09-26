Fabricator(:story) do
	title { Faker::Lorem.words(5).join(' ') }
	description { Faker::Lorem.sentences(2).join(' ') }
	large_cover { File.open("public/tmp/mrec1.jpg", "w") }
	# before_create { |story| story.large_cover = File.open("public/tmp/mrec1.jpg", "w") }
end

Fabricator(:invalid_story, from: :story) do
	title { nil }
end