class Restaurant < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  belongs_to :admin
  has_one :restaurant_schedule
  has_many :dishes
  has_many :beverages
  has_many :tags
  has_many :menus
  has_many :orders
  has_many :workers

  before_validation :generate_code, on: :create
  
  validates :cnpj, :admin, :email, uniqueness: true
  validates :brand_name, :corporate_name, :email, :cnpj, :telephone_number, :full_address, presence: true
  validates :email, format: {with: EMAIL_REGEX}
  validates :telephone_number, length: { minimum: 10, maximum: 11 }
  validate :cnpj_is_valid?


  private

  def cnpj_is_valid?    
    errors.add(:cnpj, 'não é válido') unless CNPJ.valid?(cnpj)   
  end


  def generate_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end
end
