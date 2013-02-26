class AddPlaceIdToNote < ActiveRecord::Migration
  def change
  	add_column :notes, :place_id, :integer
  end
end
