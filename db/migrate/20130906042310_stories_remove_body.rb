class StoriesRemoveBody < ActiveRecord::Migration
  def up
  	remove_column :stories, :body
  end

  def down
  	add_column :stories, :body, :string
  end
end
