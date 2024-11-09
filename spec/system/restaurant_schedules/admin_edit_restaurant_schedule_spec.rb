require 'rails_helper'

describe 'Administrador edita um horario' do
  it 'e deve estar autenticado' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                            email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                            wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                            fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                            sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

    visit edit_restaurant_schedule_path(restaurant_schedule.id)

    expect(current_path).to eq new_admin_session_path
  end

  it 'a partir da uma pagina de detalhes'  do

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
    visit root_path
    click_on 'Meu Restaurante'
    click_on 'Meu Hórario'
    click_on 'Editar'

    expect(page).to have_content 'Editar Horario'
    expect(page).to have_field('Abertura Segunda Feira', with: '08:00')
  
    expect(page).to have_field('Cierre Segunda Feira', with: '18:00')
    expect(page).to have_field('Abertura Terza Feira', with: '08:00')
    expect(page).to have_field('Cierre Terza Feira', with: '18:00')
    expect(page).to have_field('Abertura Quarta Feira', with: '08:00')
    expect(page).to have_field('Cierre Quarta Feira', with: '18:00')
    expect(page).to have_field('Abertura Quinta Feira', with: '08:00')
    expect(page).to have_field('Cierre Quinta Feira', with: '18:00')
    expect(page).to have_field('Abertura Sexta Feira', with: '08:00')
    expect(page).to have_field('Cierre Sexta Feira', with: '18:00')
    expect(page).to have_field('Abertura Sabado', with: '08:00')
    expect(page).to have_field('Cierre Sabado', with: '18:00')
    expect(page).to have_field('Abertura Domingo', with: '08:00')
    expect(page).to have_field('Cierre Domingo', with: '18:00')
  end

  it 'com sucesso'  do

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
    visit root_path
    click_on 'Meu Restaurante'
    click_on 'Meu Hórario'
    click_on 'Editar'

    fill_in 'Abertura Segunda Feira', with: '09:00'
    fill_in 'Cierre Segunda Feira', with: '19:00'
    click_on 'Enviar'
    click_on 'Meu Hórario'

    expect(page).to have_content 'Segunda Feira 09:00 19:00'
    expect(page).to have_content 'Domingo 08:00 18:00'
  end

  it 'se pertenece ao Administrador' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

    second_admin = Admin.create!(name: 'Carlos', last_name: 'Martinez', cpf: '79404816060', 
                    email: 'carlos@email.com', password: '123456789123')
    second_restaurant = Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 28176493000134, 
                  full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                  email: 'contato@mcdonalsp.com' ,telephone_number: 11999695714, admin: second_admin)
    second_restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                      wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                      fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                      sun_open: '08:00', sun_close: '18:00', restaurant: second_restaurant )

    login_as(admin)
    visit edit_restaurant_schedule_path(second_restaurant_schedule.id)

    expect(current_path).to eq restaurant_schedule_path(restaurant_schedule.id)
  end
end