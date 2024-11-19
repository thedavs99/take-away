class AddDescriptionToOrder < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :description, :string
  end
end
