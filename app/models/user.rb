class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  belongs_to :restaurant
  validates :email, :cpf, presence: true
  validates :email, format: {with: EMAIL_REGEX}
  validate :cpf_is_valid?

  enum status: { inactive: 0, active: 2 }

  private
  
  def cpf_is_valid?
    unless CPF.valid?(self.cpf)
      errors.add(:cpf, 'não é válido')
    end
  end
end
