class StoriesAddSlug < ActiveRecord::Migration
  def up
  	add_column :stories, :slug, :string
  	add_index :stories, :slug
  end

  def down
  	remove_column :stories, :slug
  end
end
