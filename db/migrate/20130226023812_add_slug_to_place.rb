class AddSlugToPlace < ActiveRecord::Migration
  def change
  	add_column :places, :slug, :string
  end
end
