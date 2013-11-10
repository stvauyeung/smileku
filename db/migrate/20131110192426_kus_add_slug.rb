class KusAddSlug < ActiveRecord::Migration
  def up
  	add_column :kus, :slug, :string
  	add_index :kus, :slug
  end

  def down
  	remove_column :kus, :slug
  end
end
