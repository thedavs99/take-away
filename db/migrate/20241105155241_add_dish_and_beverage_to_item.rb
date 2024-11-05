class AddDishAndBeverageToItem < ActiveRecord::Migration[7.2]
  def change
    add_reference :items, :dish, foreign_key: true
    add_reference :items, :beverage, foreign_key: true
  end
end
