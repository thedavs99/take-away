require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe '' do
    context '#valid?' do
      it 'dados devem ser orbigatórios' do
        # Arrange
        restaurant = Restaurant.new(corporate_name: '', brand_name: '', cnpj: '', full_address: '', email: '' ,telephone_number: '')
        # Act
        restaurant.valid?

        # Assert
        expect(restaurant.errors.include?(:corporate_name)).to be true
        expect(restaurant.errors.include?(:brand_name)).to be true
        expect(restaurant.errors.include?(:cnpj)).to be true
        expect(restaurant.errors.include?(:full_address)).to be true
        expect(restaurant.errors.include?(:email)).to be true
        expect(restaurant.errors.include?(:telephone_number)).to be true
      end
      
      it 'CNPJ deve ser valido' do
        first_restaurant = Restaurant.new(cnpj: '1234567')
        first_restaurant.valid?
        second_restaurant = Restaurant.new(cnpj: 26219781000101)
        second_restaurant.valid?

        expect(first_restaurant.errors.include?(:cnpj)).to be true
        expect(second_restaurant.errors.include?(:cnpj)).to be false
      end

      it 'Email deve ser valido' do
        first_restaurant = Restaurant.new(email: 'david@e')
        first_restaurant.valid?
        second_restaurant = Restaurant.new(email: 'david@email.com')
        second_restaurant.valid?
        third_restaurant = Restaurant.new(email: 'david.com')
        third_restaurant.valid?
        ford_restaurant = Restaurant.new(email: 'davi')
        ford_restaurant.valid?

        expect(first_restaurant.errors.include?(:email)).to be true
        expect(second_restaurant.errors.include?(:email)).to be false
        expect(third_restaurant.errors.include?(:email)).to be true
        expect(ford_restaurant.errors.include?(:email)).to be true
      end

      it 'Telefone deve ser um campo com 10 ou 11 caracteres.' do
        first_restaurant = Restaurant.new(telephone_number: 111111111)
        first_restaurant.valid?
        second_restaurant = Restaurant.new(telephone_number: 1111111111)
        second_restaurant.valid?
        third_restaurant = Restaurant.new(telephone_number: 11111111111)
        third_restaurant.valid?
        ford_restaurant = Restaurant.new(telephone_number: 111111111111)
        ford_restaurant.valid?

        expect(first_restaurant.errors.include?(:telephone_number)).to be true
        expect(second_restaurant.errors.include?(:telephone_number)).to be false
        expect(third_restaurant.errors.include?(:telephone_number)).to be false
        expect(ford_restaurant.errors.include?(:telephone_number)).to be true      
      end
    end

    context 'gera um codigo aleatório' do

      it 'ao criar um novo restaurante' do
        admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                              email: 'david@email.com', password: '123456789123')
        restaurant = Restaurant.new(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 26219781000101, 
                                        full_address: 'Rua Henrique Schaumann, 80/124 - Cerqueira César, São Paulo - SP, 05413-010', 
                                        email: 'contato@mcdonaldsp.com' ,telephone_number: 11999695710, admin: admin)

        restaurant.save!
        result = restaurant.code

        expect(result).not_to be_empty
        expect(result.length).to eq 6
      end

      it 'é um codigo unico' do
        first_admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                              email: 'david@email.com', password: '123456789123')
        first_restaurant = Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 26219781000101, 
                                        full_address: 'Rua Henrique Schaumann, 80/124 - Cerqueira César, São Paulo - SP, 05413-010', 
                                        email: 'contato@mcdonaldsp.com' ,telephone_number: 11999695710, admin: first_admin)
        second_admin = Admin.create!(name: 'Carlos', last_name: 'Martinez', cpf: '79404816060', 
                                        email: 'carlos@email.com', password: '123456789123')
        second_restaurant = Restaurant.new(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 28176493000134, 
                                      full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                                      email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: second_admin)

        second_restaurant.save!
        
        expect(second_restaurant.code).not_to eq first_restaurant.code
      end

      it 'é um codigo não pode ser igual' do
        first_admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                              email: 'david@email.com', password: '123456789123')
        allow(SecureRandom).to receive(:alphanumeric).and_return('ABC23456')
        Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 26219781000101, 
                                        full_address: 'Rua Henrique Schaumann, 80/124 - Cerqueira César, São Paulo - SP, 05413-010', 
                                        email: 'contato@mcdonaldsp.com' ,telephone_number: 11999695710, admin: first_admin)
        second_admin = Admin.create!(name: 'Carlos', last_name: 'Martinez', cpf: '79404816060', 
                                        email: 'carlos@email.com', password: '123456789123')
        allow(SecureRandom).to receive(:alphanumeric).and_return('ABC23456')
        second_restaurant = Restaurant.new(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 28176493000134, 
                                      full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                                      email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: second_admin)

        second_restaurant.valid?
        
        expect(second_restaurant.errors.include?(:code)).to be true
      end
    end

    it 'Usuário cadastra segundo restaurante' do
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                    email: 'david@email.com', password: '123456789123')
      Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                      full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                      email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      restaurant = Restaurant.new(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 28176493000134, 
                      full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                      email: 'contato@mcdonaldsp.com' ,telephone_number: 11999695714, admin: admin)
      
      expect(restaurant.valid?).to be_falsey
    end

    it 'Usuario cadastra restaurante de outro usuario' do
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                            email: 'david@email.com', password: '123456789123')
      Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                          full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                          email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      restaurant = Restaurant.new(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                                  full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                                  email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)

      restaurant.valid?

      expect(restaurant.valid?).to be_falsey
      expect(restaurant.errors.include?(:cnpj)).to be true
      expect(restaurant.errors.include?(:email)).to be true      
    end
  end
end
