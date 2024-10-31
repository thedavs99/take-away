class DishPreviousPrice < ApplicationRecord
  belongs_to :dish_portion
  validates :price, presence: true
end
