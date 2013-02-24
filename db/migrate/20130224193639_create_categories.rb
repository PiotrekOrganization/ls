class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.float :lat
      t.float :lng
      t.float :round
      t.string :name

      t.timestamps
    end
  end
end
