class AddPriceToDishPortion < ActiveRecord::Migration[7.2]
  def change
    add_column :dish_portions, :price, :integer
  end
end
