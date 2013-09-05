Fabricator(:user) do
	username { Faker::Internet.email }
	email { Faker::Internet.user_name }
	password { Faker::Lorem.words(1) }
end