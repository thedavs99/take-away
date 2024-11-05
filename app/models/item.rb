class Item < ApplicationRecord
  belongs_to :dish, optional: true
  belongs_to :beverage, optional: true
  belongs_to :menu
end
