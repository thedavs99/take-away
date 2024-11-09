class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :cpf
      t.integer :status, default: 0
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
