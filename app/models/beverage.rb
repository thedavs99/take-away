class Beverage < ApplicationRecord
  belongs_to :restaurant
  has_many :beverage_portions
  has_many :items
  has_many :menus, through: :items
  has_one_attached :image
  
  validates :name, :description, :calories, presence: true

  enum status: { inactive: 0, active: 2 }

end
