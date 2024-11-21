require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe "#valid?" do
    it 'start_date não pode ficar em branco se houver end_date' do
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                    email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                      full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                      email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                      wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                      fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                      sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
      menu = Menu.new(name: 'Almoço', restaurant: restaurant, start_date: '', end_date: '2024-11-20')

      menu.valid?

      expect(menu.errors.include?(:start_date)).to be true  
    end    

    it 'end_date não pode ficar em branco se houver start_date' do
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                    email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                      full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                      email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                      wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                      fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                      sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
      menu = Menu.new(name: 'Almoço', restaurant: restaurant, end_date: '', start_date: '2024-11-20')

      menu.valid?

      expect(menu.errors.include?(:end_date)).to be true  
    end   
  end
end
