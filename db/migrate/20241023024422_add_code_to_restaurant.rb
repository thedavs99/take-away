class AddCodeToRestaurant < ActiveRecord::Migration[7.2]
  def change
    add_column :restaurants, :code, :string
  end
end
