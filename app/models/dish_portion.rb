class DishPortion < ApplicationRecord
  belongs_to :dish
  has_many :dish_previous_prices
  has_many :orderable_dishes
  has_many :carts, through: :orderable_dishes
  
  after_create :create_price
  validates :price, :description, presence: true

  private
  def create_price
    self.dish_previous_prices.create!(price: self.price, start_date: Date.today )
  end
end
