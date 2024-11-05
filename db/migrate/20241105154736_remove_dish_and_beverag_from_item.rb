class RemoveDishAndBeveragFromItem < ActiveRecord::Migration[7.2]
  def change
    remove_reference :items, :dish, null: false, foreign_key: true
    remove_reference :items, :beverage, null: false, foreign_key: true
  end
end
