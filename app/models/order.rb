class Order < ApplicationRecord
  has_many :orderable_dishes
  has_many :dish_portions, through: :orderable_dishes
  has_many :orderable_beverages
  has_many :beverage_portions, through: :orderable_beverages
  belongs_to :restaurant
  validate :email_telefone

  enum status: { awaiting_kitchen_confirmation: 0, in_preparation: 2, canceled: 4, ready: 6, delivered: 8 }

  def total
    self.orderable_dishes.to_a.sum { |orderable_dish| orderable_dish.total} + self.orderable_beverages.to_a.sum { |orderable_beverage| orderable_beverage.total}
  end
  
  private

  def email_telefone
    if self.telephone_number.blank? && self.email.blank?
     errors.add(:base, "#{Order.model_name.human} não é valido Por favor, preencha o campo de telefone ou o campo de e-mail.") 
    end
  end
end
