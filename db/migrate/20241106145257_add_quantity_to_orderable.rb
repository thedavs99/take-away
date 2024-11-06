class AddQuantityToOrderable < ActiveRecord::Migration[7.2]
  def change
    add_column :orderables, :quantity, :integer
  end
end
