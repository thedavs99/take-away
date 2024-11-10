require 'rails_helper'

describe 'Usuario atualiza um prato' do
  it 'e não é o dono' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
    second_admin = Admin.create!(name: 'Carlos', last_name: 'Martinez', cpf: '79404816060', 
                email: 'carlos@email.com', password: '123456789123')
    second_restaurant = Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 28176493000134, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonalsp.com' ,telephone_number: 11999695714, admin: second_admin)
    second_restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                  wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                  fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                  sun_open: '08:00', sun_close: '18:00', restaurant: second_restaurant )
    dish = Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                  calories: 174, restaurant: second_restaurant, status: :inactive)


    # Act
    login_as(admin, scope: :admin)
    post(active_dish_path(dish.id))

    # Assert
    expect(response).to redirect_to(root_path)
  end
end