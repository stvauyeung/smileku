class StoriesAddLargeAndSmallCover < ActiveRecord::Migration
  def change
  	add_column :stories, :large_cover_url, :string
  	add_column :stories, :small_cover_url, :string
  end
end
