class AddAdminToRestaurant < ActiveRecord::Migration[7.2]
  def change
    add_reference :restaurants, :admin, null: false, foreign_key: true
  end
end
