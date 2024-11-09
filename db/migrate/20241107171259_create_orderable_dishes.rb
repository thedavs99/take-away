class CreateOrderableDishes < ActiveRecord::Migration[7.2]
  def change
    create_table :orderable_dishes do |t|
      t.integer :quantity
      t.references :cart,foreign_key: true
      t.references :order, foreign_key: true
      t.references :dish_portion, foreign_key: true

      t.timestamps
    end
  end
end
