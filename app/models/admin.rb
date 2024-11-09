
class Admin < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, :last_name, :cpf, presence: true
  validate :cpf_is_valid?
  validates :cpf, uniqueness: true

  after_create :set_worker


  has_one :restaurant

  enum admin_type: { worker: 0, owner: 2 }

  private
  def cpf_is_valid?
    unless CPF.valid?(self.cpf)
      errors.add(:cpf, 'não é válido')
    end
  end

  def set_worker
    user = User.find_by(email: self.email, cpf: self.cpf)
    if user
      user.active!
      self.worker!
      self.restaurant = user.restaurant
    end    
  end
end
