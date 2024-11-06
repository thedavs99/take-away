class CreateOrderables < ActiveRecord::Migration[7.2]
  def change
    create_table :orderables do |t|
      t.references :dish_portion, foreign_key: true
      t.references :beverage_portion, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
