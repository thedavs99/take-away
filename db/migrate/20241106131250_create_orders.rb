class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :telephone_number
      t.string :email
      t.string :cpf
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
