class RemoveStoryCovers < ActiveRecord::Migration
  def up
  	remove_column :stories, :large_cover_url
  	remove_column :stories, :small_cover_url
  end

  def down
  	add_column :stories, :large_cover_url, :string
  	add_column :stories, :small_cover_url, :string
  end
end
