class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :beverage, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
