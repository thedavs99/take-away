class AddPriceToBeveragePreviousPrices < ActiveRecord::Migration[7.2]
  def change
    add_column :beverage_previous_prices, :price, :integer
  end
end
