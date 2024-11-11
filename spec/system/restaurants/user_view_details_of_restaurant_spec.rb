require 'rails_helper'

describe 'Usuario vê seu restaurante' do
  it 'com sucesso' do
    # Arrange
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                        email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 26219781000101, 
                        full_address: 'Rua Henrique Schaumann, 80/124 - Cerqueira César, São Paulo - SP, 05413-010', 
                        email: 'contato@mcdonaldsp.com' ,telephone_number: 11999695710, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                        wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                        fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                        sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
    Worker.create!(email: 'luna@email.com', cpf: '59868419050', restaurant: restaurant)
    user = User.create!(name: 'Luna', last_name: 'Garcia', cpf: '59868419050', 
                  email: 'luna@email.com', password: '123456789123')
    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu Restaurante'


    # Assert
    expect(current_path).to eq restaurant_path(restaurant.id)
    expect(page).to have_content("Restaurante: McDonald's")
    expect(page).to have_content("Razão Social: McDonald's São Paulo")
    expect(page).to have_content("CNPJ: 26219781000101")
    expect(page).to have_content('Endereço Completo: Rua Henrique Schaumann, 80/124 - Cerqueira César, São Paulo - SP, 05413-010')
    expect(page).to have_content('E-mail: contato@mcdonaldsp.com')
    expect(page).to have_content('Telefone: 11999695710') 
  end
  
  it 'e ve Aberto' do
    # Arrange
    
    travel_to(Time.zone.local(2004, 11, 24, 10, 04, 44))
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                        email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 26219781000101, 
                        full_address: 'Rua Henrique Schaumann, 80/124 - Cerqueira César, São Paulo - SP, 05413-010', 
                        email: 'contato@mcdonaldsp.com' ,telephone_number: 11999695710, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                        wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                        fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                        sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
    Worker.create!(email: 'luna@email.com', cpf: '59868419050', restaurant: restaurant)
    user = User.create!(name: 'Luna', last_name: 'Garcia', cpf: '59868419050', 
                  email: 'luna@email.com', password: '123456789123')
    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu Restaurante'


    # Assert

    expect(page).to have_content("Aberto")
  end

  it 'e ve Fechado' do
    # Arrange
    travel_to(Time.zone.local(2004, 11, 24, 00, 04, 44))
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                        email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 26219781000101, 
                        full_address: 'Rua Henrique Schaumann, 80/124 - Cerqueira César, São Paulo - SP, 05413-010', 
                        email: 'contato@mcdonaldsp.com' ,telephone_number: 11999695710, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                        wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                        fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                        sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
    Worker.create!(email: 'luna@email.com', cpf: '59868419050', restaurant: restaurant)
    user = User.create!(name: 'Luna', last_name: 'Garcia', cpf: '59868419050', 
                  email: 'luna@email.com', password: '123456789123')
    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu Restaurante'

    # Assert
    expect(page).to have_content("Fechado")
  end
end