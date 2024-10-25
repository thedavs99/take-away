class CreateRestaurantSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :restaurant_schedules do |t|
      t.time :mon_open

      t.timestamps
    end
  end
end
