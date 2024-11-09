class DropOrderable < ActiveRecord::Migration[7.2]
  def change
    drop_table :orderables do |t|
      t.integer "dish_portion_id"
      t.integer "beverage_portion_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "quantity"
      t.integer "order_id", null: false
      t.index ["beverage_portion_id"], name: "index_orderables_on_beverage_portion_id"
      t.index ["dish_portion_id"], name: "index_orderables_on_dish_portion_id"
      t.index ["order_id"], name: "index_orderables_on_order_id"
    end
  end
end
