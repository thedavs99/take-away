class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :items
  has_many :dishes, through: :items
  has_many :beverages, through: :items

  validates :name, presence: true
  validate :name, :name_unique?

  private

  def name_unique?
    errors.add(:name, 'já está em uso') if self.restaurant.menus.exists?(name: self.name) && self.id.nil?
  end    
end
