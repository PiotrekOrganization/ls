class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.boolean :private_view
      t.boolean :private_write

      t.timestamps
    end
  end
end
