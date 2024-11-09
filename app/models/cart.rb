class Cart < ApplicationRecord
  has_many :orderable_dishes
  has_many :dish_portions, through: :orderable_dishes
  has_many :orderable_beverages
  has_many :beverage_portions, through: :orderable_beverages


  def total
    self.orderable_dishes.to_a.sum { |orderable_dish| orderable_dish.total} + self.orderable_beverages.to_a.sum { |orderable_beverage| orderable_beverage.total}
  end


end
