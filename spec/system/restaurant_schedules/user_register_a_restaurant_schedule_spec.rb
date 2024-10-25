require 'rails_helper'

describe 'Usuario cadastra um restaurante' do
  it 'ao fazer login' do
    # Arrange
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)

    login_as(admin)
    visit root_path

    # Assert
    expect(page).to have_content('Horário de funcionamento')
    expect(page).to have_field('Segunda Feira')
    expect(page).to have_field('Terza Feira')
    expect(page).to have_field('Quarta Feira')
    expect(page).to have_field('Quinta Feira')
    expect(page).to have_field('Sexta Feira')
    expect(page).to have_field('Sabado')
    expect(page).to have_field('Domingo')
  end

  it 'e ve dados do restaurante' do
    # Arrange
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                  full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                  email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    # Act
    login_as(admin)
    visit root_path

    fill_in 'Abertura Segunda Feira', with: '08:00'
    fill_in 'Cierre Segunda Feira', with: '18:00'
    fill_in 'Abertura Terza Feira', with: '08:00'
    fill_in 'Cierre Terza Feira', with: '18:00'
    fill_in 'Abertura Quarta Feira', with: '08:00'
    fill_in 'Cierre Quarta Feira', with: '18:00'
    fill_in 'Abertura Quinta Feira', with: '08:00'
    fill_in 'Cierre Quinta Feira', with: '18:00'
    fill_in 'Abertura Sexta Feira', with: '08:00'
    fill_in 'Cierre Sexta Feira', with: '18:00'
    fill_in 'Abertura Sabado', with: '08:00'
    fill_in 'Cierre Sabado', with: '18:00'
    fill_in 'Abertura Domingo', with: '08:00'
    fill_in 'Cierre Domingo', with: '18:00'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq restaurant_path(restaurant)
  end

  it 'com dados incompletos' do
    # Arrange
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                          email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                  full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                  email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    # Act
    login_as(admin)
    visit root_path
    fill_in 'Abertura Segunda Feira', with: ''
    fill_in 'Cierre Segunda Feira', with: ''
    fill_in 'Abertura Terza Feira', with: ''
    fill_in 'Cierre Terza Feira', with: ''
    fill_in 'Abertura Quarta Feira', with: ''
    fill_in 'Cierre Quarta Feira', with: ''
    fill_in 'Abertura Quinta Feira', with: ''
    fill_in 'Cierre Quinta Feira', with: ''
    fill_in 'Abertura Sexta Feira', with: ''
    fill_in 'Cierre Sexta Feira', with: ''
    fill_in 'Abertura Sabado', with: ''
    fill_in 'Cierre Sabado', with: ''
    fill_in 'Abertura Domingo', with: ''
    fill_in 'Cierre Domingo', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Restaurante não cadastrado'
    expect(page).to have_content 'Abertura Segunda Feira não pode ficar em branco'
    expect(page).to have_content 'Cierre Segunda Feira não pode ficar em branco'
    expect(page).to have_content 'Abertura Domingo não pode ficar em branco'
    expect(page).to have_content 'Cierre Domingo não pode ficar em branco'
  end

  it 'Usuario cadastra segundo horario' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

    login_as(admin)
    visit new_restaurant_schedule_path
    expect(current_path).to eq(restaurant_path(restaurant.id))
  end
end