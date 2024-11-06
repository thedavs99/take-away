class RemovePriceFromDishPortions < ActiveRecord::Migration[7.2]
  def change
    remove_column :dish_portions, :price, :float
  end
end
