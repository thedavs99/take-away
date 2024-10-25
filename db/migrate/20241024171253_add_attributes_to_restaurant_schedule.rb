class AddAttributesToRestaurantSchedule < ActiveRecord::Migration[7.2]
  def change
    add_column :restaurant_schedules, :mon_close, :time
    add_column :restaurant_schedules, :tue_open, :time
    add_column :restaurant_schedules, :tue_close, :time
    add_column :restaurant_schedules, :wed_open, :time
    add_column :restaurant_schedules, :wed_close, :time
    add_column :restaurant_schedules, :thu_open, :time
    add_column :restaurant_schedules, :thu_close, :time
    add_column :restaurant_schedules, :fri_open, :time
    add_column :restaurant_schedules, :fri_close, :time
    add_column :restaurant_schedules, :sat_open, :time
    add_column :restaurant_schedules, :sat_close, :time
    add_column :restaurant_schedules, :sun_open, :time
    add_column :restaurant_schedules, :sun_close, :time
    add_reference :restaurant_schedules, :restaurant, null: false, foreign_key: true
  end
end
