class AddLatitudeLongitudetoNote < ActiveRecord::Migration
  def change
  	add_column :notes , :latitude , :float 
  	add_column :notes , :longitude , :float 
  end

  
end
