class AddPriceToDishPreviousPrices < ActiveRecord::Migration[7.2]
  def change
    add_column :dish_previous_prices, :price, :integer
  end
end
