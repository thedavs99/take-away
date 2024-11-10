require 'rails_helper'

describe 'Usuario se cadastra' do
  it 'com sucesso' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
    Worker.create!(email: 'luna@email.com', cpf: '59868419050', restaurant: restaurant)

    visit root_path
    click_on 'Usuario'
    click_on 'Crie sua conta!'
    fill_in 'Nome', with: 'Luna'
    fill_in 'Sobrenome', with: 'Garcia'
    fill_in 'CPF', with: '59868419050'
    fill_in 'E-mail', with: 'luna@email.com'
    fill_in 'Senha', with: '123456789123'
    fill_in 'Confirme sua senha', with: '123456789123'
    click_on 'Criar conta'

    expect(page).to have_content('Meu Restaurante')  
    expect(page).not_to have_content('Minhas Bebidas')   
    expect(page).not_to have_content('Meus Pratos')     
    expect(page).not_to have_content('Usuarios')   
    expect(page).not_to have_content('Meus Pedidos') 
  end

  it 'e não pode cadastrarse se não é pre-cadastrado' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

    visit root_path
    click_on 'Usuario'
    click_on 'Crie sua conta!'
    fill_in 'Nome', with: 'Luna'
    fill_in 'Sobrenome', with: 'Garcia'
    fill_in 'CPF', with: '59868419050'
    fill_in 'E-mail', with: 'luna@email.com'
    fill_in 'Senha', with: '123456789123'
    fill_in 'Confirme sua senha', with: '123456789123'
    click_on 'Criar conta'

    expect(page).to have_content('Não foi possível salvar usuario')  
    expect(page).to have_content('E-mail não pre-cadastrado') 
    expect(page).to have_content('CPF não pre-cadastrado')     
  end
end