class CreateKusTable < ActiveRecord::Migration
  def change
  	create_table :kus do |t|
  		t.text :body
  		t.references :user
  		t.references :story
  		t.integer :parent_id
  		t.integer :number

  		t.timestamps
  	end
  end
end
