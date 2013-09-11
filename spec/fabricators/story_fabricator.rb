Fabricator(:story) do
	title { Faker::Lorem.words(5).join(' ') }
	description { Faker::Lorem.sentences(2).join(' ') }
	large_cover_url { ["http://ih1.redbubble.net/image.14704393.7467/fc,550x550,black.u3.jpg", "http://ih1.redbubble.net/image.14679585.1725/flat,800x800,070,f.u1.jpg", "http://ih1.redbubble.net/image.14693218.0468/flat,800x800,070,f.u1.jpg", "http://ih3.redbubble.net/image.14716138.5049/fc,550x550,eggplant.u2.jpg"].sample }
	small_cover_url { ["http://ih3.redbubble.net/image.14570559.0590/fc,220x200,navy.u2.jpg", "http://ih0.redbubble.net/image.14637395.4282/fc,220x200,white.u2.jpg", "http://ih3.redbubble.net/image.14597774.8992/fc,220x200,lemon.u2.jpg", "http://ih0.redbubble.net/image.14651567.3326/fc,220x200,asphalt.u2.jpg", "http://ih0.redbubble.net/image.14562607.6455/flat,220x200,075,t.u2.jpg"].sample }
end

Fabricator(:invalid_story, from: :story) do
	title { nil }
end