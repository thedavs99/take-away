class Orderable < ApplicationRecord
  belongs_to :dish_portion
  belongs_to :beverage_portion
  belongs_to :order
end
