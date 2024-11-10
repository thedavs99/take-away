class Worker < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  belongs_to :restaurant
  validates :email, :cpf, presence: true
  validates :email, format: {with: EMAIL_REGEX}
  validate :email_cpf_uniqueness
  validate :cpf_is_valid?

  enum status: { inactive: 0, active: 2 }

  private
  
  def cpf_is_valid?
    unless CPF.valid?(self.cpf)
      errors.add(:cpf, 'não é válido')
    end
  end

  def email_cpf_uniqueness
    errors.add(:cpf, 'ja cadastrado') if User.find_by(cpf: self.cpf) || Admin.find_by(cpf: self.cpf)
    errors.add(:email, 'ja cadastrado') if User.find_by(email: self.email) || Admin.find_by(email: self.email)
  end
end
