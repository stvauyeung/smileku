class CreatePosts < ActiveRecord::Migration
  def up
  	create_table :posts do |t|
  		t.string :text
  		t.string :title
  		t.string :header
  		t.string :mrec
  		t.string :photo_link
  		t.references :user
  		t.timestamps
  	end
  end

  def down
  	drop_table :posts
  end
end
