class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :dish_portions
  has_one_attached :image

  validates :name, :description, :calories, presence: true
  enum status: { inactive: 0, active: 2 }
end
