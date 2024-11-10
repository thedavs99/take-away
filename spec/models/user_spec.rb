require 'rails_helper'

RSpec.describe User, type: :model do

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
    second_user = User.new(name: 'Luna', last_name: 'Martinez', cpf: '38905602029', 
                  email: 'luna@email.com', password: '123456789123')
    third_user = User.new(name: 'Luna', last_name: 'Martinez', cpf: '59868419050', 
                  email: 'luna_dois@email.com', password: '123456789123')
    
    second_user.valid?
    third_user.valid?

    expect(second_user.errors.include?(:email)).to be true  
    expect(third_user.errors.include?(:cpf)).to be true 
  end

end
