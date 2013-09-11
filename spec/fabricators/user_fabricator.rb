Fabricator(:user) do
	username { Faker::Internet.user_name }
	email { Faker::Internet.email }
	password { Faker::Lorem.words(1) }
end