class AddStoryCoversCarrierwave < ActiveRecord::Migration
  def up
  	add_column :stories, :large_cover, :string
  end

  def down
  	remove_column :stories, :large_cover
  end
end
