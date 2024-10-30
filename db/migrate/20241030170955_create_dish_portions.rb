class CreateDishPortions < ActiveRecord::Migration[7.2]
  def change
    create_table :dish_portions do |t|
      t.string :description
      t.float :price
      t.references :dish, null: false, foreign_key: true

      t.timestamps
    end
  end
end
