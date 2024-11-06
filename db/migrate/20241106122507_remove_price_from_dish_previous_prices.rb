class RemovePriceFromDishPreviousPrices < ActiveRecord::Migration[7.2]
  def change
    remove_column :dish_previous_prices, :price, :float
  end
end
