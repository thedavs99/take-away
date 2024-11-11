require 'rails_helper'

describe 'Administrador ve todos os pratos do seu restaurante' do
  it 'e deve estar autenticado' do
    visit dish_path(1)

    expect(current_path).to eq new_admin_session_path
  end

  it 'e deve poseer um restaurante' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')

    login_as(admin, scope: :admin)
    visit dish_path(1)

    expect(current_path).to eq new_restaurant_path
  end

  it 'e deve ter registrado o horario do restaurante' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)

    login_as(admin, scope: :admin)
    visit dish_path(1)
                
    expect(current_path).to eq new_restaurant_schedule_path    
  end

  it 'e deve estar autenticado como admin' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    Worker.create!(email: 'luna@email.com', cpf: '59868419050', restaurant: restaurant)
    user = User.create!(name: 'Luna', last_name: 'Garcia', cpf: '59868419050', 
                  email: 'luna@email.com', password: '123456789123')
    

    login_as(user, scope: :user)
    visit dish_path(1)
                
    expect(current_path).to eq root_path    
  end

  it 'com sucesso'  do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
    Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                calories: 174, restaurant: restaurant)
    

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Risotto'

    expect(page).to have_content 'Prato: Risotto'
    expect(page).to have_content 'Descrição: Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.'
    expect(page).to have_content 'Calorias: 174'
    expect(page).not_to have_field 'Nome'
  end

  it 'e não ve dos outros'  do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
    Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                calories: 174, restaurant: restaurant)
    second_admin = Admin.create!(name: 'Carlos', last_name: 'Martinez', cpf: '79404816060', 
                email: 'carlos@email.com', password: '123456789123')
    second_restaurant = Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 28176493000134, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonalsp.com' ,telephone_number: 11999695714, admin: second_admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                  wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                  fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                  sun_open: '08:00', sun_close: '18:00', restaurant: second_restaurant )
    second_dish = Dish.create!(name: 'Ragú', description: 'suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
                  calories: 177, restaurant: second_restaurant)
    

    login_as(admin, scope: :admin)
    visit dish_path(second_dish)

    expect(current_path).to eq root_path
  end
end