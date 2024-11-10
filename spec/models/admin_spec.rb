require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#valid?' do
    context 'presence' do 
      it 'false when name is empty' do
        # Arrange
        admin = Admin.new(name: '', last_name: 'Martinez', cpf: '12223111190', 
        email: 'david@email.com', password: '123456789123')

        # Assert 
        expect(admin.valid?).to be_falsey
      end

      it 'false when last_name is empty' do
        # Arrange
        admin = Admin.new(name: 'David', last_name: '', cpf: '12223111190', 
        email: 'david@email.com', password: '123456789123')

        # Assert 
        expect(admin.valid?).to be_falsey
      end

      it 'false when cpf is empty' do
        # Arrange
        admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '' , 
        email: 'david@email.com', password: '123456789123')

        # Assert 
        expect(admin.valid?).to be_falsey
      end

      it 'false when email is empty' do
        # Arrange
        admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
        email: '', password: '123456789123')

        # Assert 
        expect(admin.valid?).to be_falsey
      end
      
    end

    it 'false when email is not valid' do
      # Arrange
      admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@emailcom', password: '123456789123')

      # Assert 
      expect(admin.valid?).to be_falsey
    end

    it 'false when password.length < 12' do
      # Arrange
      admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                        email: 'david@email.com', password: '12345678912')
      
      # Assert 
      expect(admin.valid?).to be_falsey
    end

    it 'false when cpf invalid' do
      # Arrange
      admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '12345678901', 
                        email: 'david@email.com', password: '123456789123')
      
      # Assert 
      expect(admin.valid?).to be_falsey
    end

    it 'false when cpf or email is used by user' do
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                    email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                      full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                      email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                      wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                      fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                      sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
      Worker.create!(email: 'luna@email.com', cpf: '59868419050', restaurant: restaurant)
      user = User.create!(name: 'Luna', last_name: 'Garcia', cpf: '59868419050', 
                    email: 'luna@email.com', password: '123456789123')
      second_admin = Admin.new(name: 'Luna', last_name: 'Martinez', cpf: '38905602029', 
                    email: 'luna@email.com', password: '123456789123')
      third_admin = Admin.new(name: 'Luna', last_name: 'Martinez', cpf: '59868419050', 
                    email: 'luna_dois@email.com', password: '123456789123')
      
      second_admin.valid?
      third_admin.valid?

      expect(second_admin.errors.include?(:email)).to be true  
      expect(third_admin.errors.include?(:cpf)).to be true 
    end

    it 'Admin is not an restaurant_owner' do
      # Arrange
      admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                        email: 'david@email.com', password: '123456789123')
      
      # Assert 
      expect(admin.restaurant_owner).to be_falsey
    end
  end
end
