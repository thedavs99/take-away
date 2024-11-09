class AddAdminTypeToAdmin < ActiveRecord::Migration[7.2]
  def change
    add_column :admins, :admin_type, :integer, default: 2
  end
end
