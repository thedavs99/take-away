class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :restaurant
  validate :cpf_is_valid?
  validate :email_cpf_uniqueness
  before_validation :set_worker

  private
  
  def cpf_is_valid?
    unless CPF.valid?(self.cpf)
      errors.add(:cpf, 'não é válido')
    end
  end

  def set_worker
    worker = Worker.find_by(email: self.email, cpf: self.cpf)
    if worker
      worker.active!
      self.restaurant = worker.restaurant
    else
      errors.add(:email, 'não pre-cadastrado')
      errors.add(:cpf, 'não pre-cadastrado')
    end    
  end

  def email_cpf_uniqueness
    errors.add(:cpf, 'ja cadastrado') if User.find_by(cpf: self.cpf) || Admin.find_by(cpf: self.cpf)
    errors.add(:email, 'ja cadastrado') if User.find_by(email: self.email) || Admin.find_by(email: self.email)
  end
end
