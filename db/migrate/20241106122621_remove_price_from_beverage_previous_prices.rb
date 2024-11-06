class RemovePriceFromBeveragePreviousPrices < ActiveRecord::Migration[7.2]
  def change
    remove_column :beverage_previous_prices, :price, :float
  end
end
