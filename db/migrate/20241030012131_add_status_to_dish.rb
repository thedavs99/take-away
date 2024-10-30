class AddStatusToDish < ActiveRecord::Migration[7.2]
  def change
    add_column :dishes, :status, :integer, default: 2
  end
end
