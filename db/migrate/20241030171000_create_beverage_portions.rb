class CreateBeveragePortions < ActiveRecord::Migration[7.2]
  def change
    create_table :beverage_portions do |t|
      t.string :description
      t.float :price
      t.references :beverage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
