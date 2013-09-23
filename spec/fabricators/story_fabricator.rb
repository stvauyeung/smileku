Fabricator(:story) do
	title { Faker::Lorem.words(5).join(' ') }
	description { Faker::Lorem.sentences(2).join(' ') }
end

Fabricator(:invalid_story, from: :story) do
	title { nil }
end