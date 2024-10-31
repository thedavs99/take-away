class CreateDishPreviousPrices < ActiveRecord::Migration[7.2]
  def change
    create_table :dish_previous_prices do |t|
      t.float :price
      t.date :start_date
      t.date :end_date
      t.references :dish_portion, null: false, foreign_key: true

      t.timestamps
    end
  end
end