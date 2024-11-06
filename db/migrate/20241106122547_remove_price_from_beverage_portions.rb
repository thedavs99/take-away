class RemovePriceFromBeveragePortions < ActiveRecord::Migration[7.2]
  def change
    remove_column :beverage_portions, :price, :string
  end
end
