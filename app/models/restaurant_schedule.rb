class RestaurantSchedule < ApplicationRecord
  belongs_to :restaurant
  validates :mon_open, :mon_close, :tue_close,
  :tue_open, :wed_close, :wed_open, :thu_open, :thu_close, :fri_close, 
  :fri_open, :sat_open, :sat_close, :sun_close, :sun_open, presence: true
  validates :restaurant, uniqueness: true
  validate :check_close_after_open

  private

  def check_close_after_open 
    if mon_open && mon_close && tue_open && tue_close && wed_open && wed_close && thu_open && thu_close && fri_open && fri_close && sat_open && sat_close && sun_open && sun_close 
      errors.add(:mon_open, 'não é válido') unless mon_open < mon_close
      errors.add(:tue_open, 'não é válido') unless tue_open < tue_close
      errors.add(:wed_open, 'não é válido') unless wed_open < wed_close
      errors.add(:thu_open, 'não é válido') unless thu_open < thu_close
      errors.add(:fri_open, 'não é válido') unless fri_open < fri_close
      errors.add(:sat_open, 'não é válido') unless sat_open < sat_close
      errors.add(:sun_open, 'não é válido') unless sun_open < sun_close    
    end
  end
end
