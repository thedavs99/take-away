require 'rails_helper'

RSpec.describe Worker, type: :model do
  describe "#valid?" do
    it 'campo não pode estar vacio' do
      worker = Worker.new(email: '', cpf: '')

      worker.valid?

      expect(worker.errors.include?(:email)).to be true
      expect(worker.errors.include?(:cpf)).to be true
    end

    it 'E-mail deve ser valido' do
      worker = Worker.new(email: 'davidhotmailcom', cpf: '')

      worker.valid?

      expect(worker.errors.include?(:email)).to be true
    end

    it 'CPF deve ser valido' do
      worker = Worker.new(email: '', cpf: '11122233344')

      worker.valid?

      expect(worker.errors.include?(:cpf)).to be true
    end

    it 'false when cpf or email is used' do
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
      second_worker = Worker.new( cpf: '38905602029', 
                    email: 'luna@email.com')
      third_worker = Worker.new( cpf: '59868419050', 
                    email: 'luna_dois@email.com')
      
      second_worker.valid?
      third_worker.valid?

      expect(second_worker.errors.include?(:email)).to be true  
      expect(third_worker.errors.include?(:cpf)).to be true 
    end

    
  end
end
