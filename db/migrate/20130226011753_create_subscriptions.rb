class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :place_id
      t.float :lat
      t.float :lng
      t.float :round

      t.timestamps
    end
  end
end
