class Restaurant < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  belongs_to :admin
  validates :brand_name, :corporate_name, :email, :cnpj, :telephone_number, :full_address, presence: true
  validate :cnpj_is_valid?
  validates :email, format: {with: EMAIL_REGEX}
  validates :telephone_number, length: { minimum: 10, maximum: 11 }
  before_validation :generate_code
  validates :cnpj, :admin, :email, uniqueness: true
  has_one :restaurant_schedule
  has_many :dishes
  has_many :beverages

  private

  def cnpj_is_valid?    
    errors.add(:cnpj, 'não é válido') unless CNPJ.valid?(cnpj)   
  end


  def generate_code
    self.code = SecureRandom.alphanumeric(6).upcase unless self.code != nil
  end
end
