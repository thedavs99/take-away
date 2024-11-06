class DishPortion < ApplicationRecord
  belongs_to :dish
  has_many :dish_previous_prices
  has_many :orderables
  has_many :orders, through: :orderables
  
  after_create :create_price
  validates :price, :description, presence: true

  private
  def create_price
    self.dish_previous_prices.create!(price: self.price, start_date: Date.today )
  end
end
