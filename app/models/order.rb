class Order < ApplicationRecord
  has_many :orderables
  has_many :dishes, through: :orderables
  has_many :beverages, through: :orderables

  enum status: { awaiting_kitchen_confirmation: 0, in_preparation: 2, canceled: 4, ready: 6, delivered: 8 }
  
end
