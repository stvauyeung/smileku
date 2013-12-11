Fabricator(:following) do
	follower_id { Fabricate(:user).id }
	followed_id { Fabricate(:user).id }
end