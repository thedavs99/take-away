class BeveragePortion < ApplicationRecord
  belongs_to :beverage
  has_many :beverage_previous_prices
  
  after_create :create_price
  validates :price, :description, presence: true

  private
  def create_price
    self.beverage_previous_prices.create!(price: self.price, start_date: Date.today )
  end
end
