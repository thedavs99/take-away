class Order < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  has_many :orderable_dishes
  has_many :dish_portions, through: :orderable_dishes
  has_many :orderable_beverages
  has_many :beverage_portions, through: :orderable_beverages
  belongs_to :restaurant
  validate :email_or_telefone_validate?
  validate :cpf_is_valid?
  validates :name, :code, :status, presence: true


  enum status: { awaiting_kitchen_confirmation: 0, in_preparation: 2, canceled: 4, ready: 6, delivered: 8 }

  before_validation :generate_code, on: :create

  def total
    self.orderable_dishes.to_a.sum { |orderable_dish| orderable_dish.total} + self.orderable_beverages.to_a.sum { |orderable_beverage| orderable_beverage.total}
  end
  
  private

  def cpf_is_valid?
    unless CPF.valid?(self.cpf)
      errors.add(:cpf, 'não é válido')
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def email_or_telefone_validate?
    if self.telephone_number.blank? && self.email.blank? 
      errors.add(:base, 'Por favor, preencha o campo de telefone ou o campo de e-mail.') 

    elsif self.telephone_number
      errors.add(:telephone_number, 'Por favor, preencha corretamete o campo de telefone ou preencha o campo de e-mail.') if (self.telephone_number.length  < 10 || self.telephone_number.length  > 11)
    
    elsif self.email
      errors.add(:email, 'Por favor, preencha corretamete o campo de telefone ou preencha o campo de e-mail.') unless self.email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i) 
    end
  end
end