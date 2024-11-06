class AddPriceToBeveragePortion < ActiveRecord::Migration[7.2]
  def change
    add_column :beverage_portions, :price, :integer
  end
end
