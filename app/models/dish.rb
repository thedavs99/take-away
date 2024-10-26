class Dish < ApplicationRecord
  belongs_to :restaurant
  validates :name, :description, :calories, presence: true
end
