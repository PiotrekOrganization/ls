class AddLocalizationToGuest < ActiveRecord::Migration
  def change
  	add_column :guests, :ip_address, :string 
  	add_column :guests, :latitude, :float
  	add_column :guests, :longitude, :float
  end
end
