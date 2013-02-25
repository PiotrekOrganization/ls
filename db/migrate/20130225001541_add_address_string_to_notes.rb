class AddAddressStringToNotes < ActiveRecord::Migration
  def change
  	add_column :notes, :address, :string
  end
end
