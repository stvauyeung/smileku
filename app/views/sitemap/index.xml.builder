xml.instruct!
xml.urlset(
  'xmlns'.to_sym => "http://www.sitemaps.org/schemas/sitemap/0.9",
  'xmlns:image'.to_sym => "http://www.google.com/schemas/sitemap-image/1.1"
) do
  @static_pages.each do |page|
    xml.url do
      xml.loc "#{page}"
      xml.changefreq("monthly")
    end
  end
  xml.url do
    xml.loc "#{posts_url}"
    xml.changefreq("weekly")
  end
  xml.url do
    xml.loc "#{stories_url}"
    xml.changefreq("weekly")
  end
  @posts.each do |post|
    xml.url do
      xml.loc "#{post_url(post)}"
      xml.lastmod post.updated_at.strftime("%F")
      xml.changefreq("monthly")
    end
  end
  @stories.each do |story|
    xml.url do
      xml.loc "#{story_url(story)}"
      xml.lastmod story.updated_at.strftime("%F")
      xml.changefreq("monthly")
    end
  end
  @kus.each do |ku|
    xml.url do
      xml.loc "#{ku_url(ku)}"
      xml.lastmod ku.updated_at.strftime("%F")
      xml.changefreq("monthly")
    end
  end
  @users.each do |user|
    xml.url do
      xml.loc "#{user_url(user)}"
      xml.lastmod user.updated_at.strftime("%F")
      xml.changefreq("monthly")
    end
  end
end