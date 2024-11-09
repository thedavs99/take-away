class OrderableBeverage < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  belongs_to :beverage_portion
  validate :quantity_valid?


  def total
    self.beverage_portion.price * quantity
  end

  private

  def quantity_valid?
    errors.add(:quantity, 'não é válido') unless  quantity > 0
  end
end
