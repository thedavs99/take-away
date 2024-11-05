class AddNameToMenu < ActiveRecord::Migration[7.2]
  def change
    add_column :menus, :name, :string
  end
end
