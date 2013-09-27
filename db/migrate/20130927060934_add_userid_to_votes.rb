class AddUseridToVotes < ActiveRecord::Migration
  def up
  	add_column :votes, :user_id, :integer
  end

  def down
  	remove_column :votes, :user_id
  end
end
