class RestaurantSchedule < ApplicationRecord
  belongs_to :restaurant
  validates :mon_open, :mon_close, :tue_close,
  :tue_open, :wed_close, :wed_open, :thu_open, :thu_close, :fri_close, 
  :fri_open, :sat_open, :sat_close, :sun_close, :sun_open, presence: true
end
