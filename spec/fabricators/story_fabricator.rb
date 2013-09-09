Fabricator(:story) do
	title { Faker::Lorem.words(5) }
	description { Faker::Lorem.sentences(2) }
	large_cover_url { "http://ih1.redbubble.net/image.14704393.7467/fc,550x550,black.u3.jpg" }
end

Fabricator(:invalid_story, from: :story) do
	title { nil }
end