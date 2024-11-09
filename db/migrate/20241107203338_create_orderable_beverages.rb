class CreateOrderableBeverages < ActiveRecord::Migration[7.2]
  def change
    create_table :orderable_beverages do |t|
      t.integer :quantity
      t.references :cart, foreign_key: true
      t.references :order, foreign_key: true
      t.references :beverage_portion, foreign_key: true

      t.timestamps
    end
  end
end
