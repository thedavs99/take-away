class Beverage < ApplicationRecord
  belongs_to :restaurant
  validates :name, :description, :calories, presence: true
  has_one_attached :image
  enum status: { inactive: 0, active: 2 }
  has_many :beverage_portions
end
