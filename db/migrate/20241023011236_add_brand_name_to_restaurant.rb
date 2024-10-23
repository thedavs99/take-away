class AddBrandNameToRestaurant < ActiveRecord::Migration[7.2]
  def change
    add_column :restaurants, :brand_name, :string
  end
end
