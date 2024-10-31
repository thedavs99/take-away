class BeveragePreviousPrice < ApplicationRecord
  belongs_to :beverage_portion
  validates :price, presence: true
end
