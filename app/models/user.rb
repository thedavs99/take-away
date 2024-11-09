class User < ApplicationRecord
  belongs_to :restaurant
  validates :email, :cpf, presence: true
  validate :cpf_is_valid?

  enum status: { inactive: 0, active: 2 }

  private
  def cpf_is_valid?
    unless CPF.valid?(self.cpf)
      errors.add(:cpf, 'não é válido')
    end
  end
end
