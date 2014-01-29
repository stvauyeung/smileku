class SitemapController < ApplicationController
  def index
    @static_pages = [front_url, faq_url, contact_url]
    @users = User.all
    @posts = Post.all
    @stories = Story.all
    @kus = Ku.all
    respond_to do |format|
      format.xml
    end
  end
end