class RemoveNomeFromMenu < ActiveRecord::Migration[7.2]
  def change
    remove_column :menus, :nome, :string
  end
end
