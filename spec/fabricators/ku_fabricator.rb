Fabricator(:ku) do
	body { Faker::Lorem.paragraphs }
	user_id { Fabricate(:user).id }
	story_id { Fabricate(:story).id }
end

Fabricator(:invalid_ku, from: :ku) do
	body { nil }
end