class CreateStoryFollowings < ActiveRecord::Migration
  def change
  	create_table :listings do |t|
  		t.integer :user_id
  		t.integer :story_id
  		t.timestamps
  	end
  	add_index :listings, :user_id
  	add_index :listings, :story_id
  	add_index :listings, [:user_id, :story_id], unique: true
  end
end
