Fabricator(:listing) do
	user_id { Fabricate(:user).id }
	story_id { Fabricate(:story).id }
end