Fabricator(:ku) do
	body { Faker::Lorem.paragraphs }
end

Fabricator(:invalid_ku, from: :ku) do
	body { nil }
end