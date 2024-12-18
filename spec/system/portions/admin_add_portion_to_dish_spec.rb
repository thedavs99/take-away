require 'rails_helper'

describe 'Administrador adiciona uma porção a um prato' do
  it 'da tela de inicio' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                    email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                      email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                      wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                      fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                      sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
    Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                      calories: 174, restaurant: restaurant)
  
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Risotto'
    click_on 'Adicionar porção'
    
    expect(page).to have_field 'Descrição'    
    expect(page).to have_field 'Preço'  
  end

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
    Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                      calories: 174, restaurant: restaurant)
  
    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Risotto'
    click_on 'Adicionar porção'
    fill_in 'Descrição', with: 'Uma pessoa'
    fill_in 'Preço', with: '125'
    click_on 'Gravar'
    
    expect(page).to have_content 'Uma pessoa'  
    expect(page).to have_content '125'   
  end
end