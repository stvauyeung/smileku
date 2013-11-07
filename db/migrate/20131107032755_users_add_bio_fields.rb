class UsersAddBioFields < ActiveRecord::Migration
  def up
  	add_column :users, :location, :string
  	add_column :users, :bio, :text
  	add_column :users, :website, :string
  	add_column :users, :photo, :string
  end

  def down
  	remove_column :users, :location, :string
  	remove_column :users, :bio, :text
  	remove_column :users, :website, :string
  	remove_column :users, :photo, :string
  end
end
