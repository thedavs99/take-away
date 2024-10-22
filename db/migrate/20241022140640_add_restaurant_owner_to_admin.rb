class AddRestaurantOwnerToAdmin < ActiveRecord::Migration[7.2]
  def change
    add_column :admins, :restaurant_owner, :boolean
  end
end
