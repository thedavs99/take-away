class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :items
  has_many :dishes, through: :items
  has_many :beverages, through: :items

  validates :name, presence: true
  validate :name, :name_unique?
  validate :sazonal

  private

  def name_unique?
    errors.add(:name, 'já está em uso') if self.restaurant.menus.exists?(name: self.name) && self.id.nil?
  end    

  def sazonal
    if self.end_date
      errors.add(:start_date, 'não pode ficar em branco, se houver data de fechamento,') if self.start_date.nil?
    end 
    if self.start_date
      errors.add(:end_date, 'não pode ficar em branco, se houver data de início') if self.end_date.nil?
    end 
  end
end
