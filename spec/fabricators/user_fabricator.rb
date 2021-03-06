Fabricator(:user) do
	username { Faker::Name.first_name }
	email { Faker::Internet.email }
	password { Faker::Lorem.words(1) }
	admin false
end

Fabricator(:admin, from: :user) do
	admin true
end