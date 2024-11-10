class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :restaurant
  validate :cpf_is_valid?

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
      errors.add(:user, 'não pre-cadastrado')
    end    
  end
end
