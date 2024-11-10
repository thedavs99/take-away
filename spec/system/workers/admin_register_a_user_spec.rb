require 'rails_helper'

describe 'Administrador pre cadastra um trabalhador' do
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

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Trabalhadores'
    click_on 'Adicionar Trabalhador'
    fill_in 'E-mail', with: 'luna@email.com' 
    fill_in 'CPF', with: '04337878050' 
    click_on 'Enviar'

    expect(page).to have_content('luna@email.com')  
    expect(page).to have_content('04337878050')   
    expect(page).to have_content('Desativado')     
  end

  it 'e os campos não podem estar em branco' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Trabalhadores'
    click_on 'Adicionar Trabalhador'
    fill_in 'E-mail', with: '' 
    fill_in 'CPF', with: '' 
    click_on 'Enviar'

    expect(page).to have_content('Trabalhador não cadastrado')  
    expect(page).to have_content('E-mail não pode ficar em branco')  
    expect(page).to have_content('CPF não pode ficar em branco')      
  end

  it 'e ao usuario se cadastrar ve status ativo' do
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
    User.create!(name: 'Luna', last_name: 'Garcia', cpf: '59868419050', 
                  email: 'luna@email.com', password: '123456789123')

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Trabalhadores'

    expect(page).to have_content('luna@email.com')  
    expect(page).to have_content('59868419050')   
    expect(page).to have_content('Ativo')      
  end
end