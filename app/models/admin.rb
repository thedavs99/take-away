
class Admin < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, :last_name, :cpf, presence: true
  validate :cpf_is_valid?
  validates :cpf, uniqueness: true

  after_create :register_as_an_owner


  has_one :restaurant

  private
  def cpf_is_valid?
    unless CPF.valid?(cpf)
      errors.add(:cpf, 'não é válido')
    end
  end

  def register_as_an_owner
    self.restaurant_owner = true
  end
end
