Fabricator(:post) do
	text { Faker::Lorem.sentences(3).join(' ') }
	title { Faker::Lorem.words(5).join(' ') }
	photo_link { Faker::Internet.url }
end