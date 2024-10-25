require 'rails_helper'

describe 'usuario edita um restaurante' do
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

    visit edit_restaurant_path(restaurant.id)

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
    click_on 'Editar'

    expect(page).to have_content 'Editar Restaurante'

    expect(page).to have_field('Razão Social', with: "McDonald's Curitiba")
    expect(page).to have_field('Nome Fantasia', with: "McDonald's")
    expect(page).to have_field('CNPJ', with: 26219781000101)
    expect(page).to have_field('Telefone', with: '11999695714')
    expect(page).to have_field('E-mail', with: 'contato@mcdonaldcr.com')
    expect(page).to have_field('Endereço Completo', with: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090')
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
    click_on 'Editar'

    fill_in 'Razão Social', with: "McDonald's São Paulo"
    fill_in 'Telefone', with: '11666695714'
    click_on 'Próximo'

    expect(page).to have_content "McDonald's São Paulo"
    expect(page).to have_content '11666695714'
  end
end