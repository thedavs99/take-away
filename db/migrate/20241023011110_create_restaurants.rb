class CreateRestaurants < ActiveRecord::Migration[7.2]
  def change
    create_table :restaurants do |t|
      t.string :corporate_name
      t.integer :cnpj
      t.string :full_address
      t.string :telephone_number
      t.string :email
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
