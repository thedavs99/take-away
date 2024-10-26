class Beverage < ApplicationRecord
  belongs_to :restaurant
  validates :name, :description, :calories, presence: true
  has_one_attached :image
end
