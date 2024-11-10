
class Admin < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, :last_name, :cpf, presence: true
  validate :cpf_is_valid?
  validate :email_cpf_uniqueness


  has_one :restaurant


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
