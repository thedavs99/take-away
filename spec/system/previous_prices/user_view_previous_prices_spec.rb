require 'rails_helper'

describe 'Usuario ve o primeiro preço no historico de preços' do
  context 'de bebida' do
    it 'ao criar uma porção' do
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                    email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                        full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                        email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                        wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                        fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                        sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
      beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, 
                          restaurant: restaurant, status: :inactive)
      BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)
    
      login_as(admin)
      visit root_path
      click_on 'Minhas Bebidas'
      click_on 'Coca-Cola'
      click_on 'Lata'
      
      within 'table' do
        expect(page).to have_content 'Historico de preços'   
        expect(page).to have_content '20'   
      end
    end
      
    it 'ao editar um preço' do
      travel_to(Time.new(2004, 11, 24, 00, 04, 44))
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                    email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                        full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                        email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                        wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                        fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                        sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
      beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, 
                          restaurant: restaurant, status: :inactive)
      BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)
      travel_to(Time.new(2008, 12, 24, 00, 04, 44))

      login_as(admin)
      visit root_path
      click_on 'Minhas Bebidas'
      click_on 'Coca-Cola'
      click_on 'Lata'
      fill_in 'Editar Preço', with: 22
      click_on "Atualizar Preço"
      click_on 'Lata'

      within 'table' do
        expect(page).to have_content '2004-11-24'
        expect(page).to have_content '2008-12-24'
        expect(page).to have_content '22'  
        expect(page).to have_content '20' 
      end    
    end

    it 'e não ve dos outros' do
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                    email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                        full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                        email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                        wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                        fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                        sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
      beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, 
                          restaurant: restaurant)
      beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20.12, beverage: beverage)
      second_admin = Admin.create!(name: 'Carlos', last_name: 'Martinez', cpf: '79404816060', 
                                  email: 'carlos@email.com', password: '123456789123')
      second_restaurant = Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 28176493000134, 
                                            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                                            email: 'contato@mcdonalsp.com' ,telephone_number: 11999695714, admin: second_admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                                  wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                                  fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                                  sun_open: '08:00', sun_close: '18:00', restaurant: second_restaurant )
    
      login_as(second_admin)
      visit beverage_beverage_portion_path(beverage, beverage_portion.id)
      
      expect(current_path).to eq root_path
    end
  end

  context 'de pratos' do
    it 'ao criar uma porção' do
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                      full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                        email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                        wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                        fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                        sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
      dish = Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                        calories: 174, restaurant: restaurant)
      DishPortion.create!(description: 'Uma pessoa', price: 125, dish: dish)
    
      login_as(admin)
      visit root_path
      click_on 'Meus Pratos'
      click_on 'Risotto'
      click_on 'Uma pessoa'
    
      within 'table' do
        expect(page).to have_content 'Historico de preços'   
        expect(page).to have_content '125'   
      end 
    end

    it 'ao editar um preço' do
      travel_to(Time.new(2004, 11, 24, 00, 04, 44))
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                        full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                        email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                          wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                          fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                          sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
      dish = Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                          calories: 174, restaurant: restaurant)
      DishPortion.create!(description: 'Uma pessoa', price: 125, dish: dish)
      first_date = Time.zone.today
      travel_to(Time.new(2008, 12, 24, 00, 04, 44))

      login_as(admin)
      visit root_path
      click_on 'Meus Pratos'
      click_on 'Risotto'
      click_on 'Uma pessoa'
      fill_in 'Editar Preço', with: 120
      click_on "Atualizar Preço"
      click_on 'Uma pessoa'

      within 'table' do
        expect(page).to have_content '2004-11-24'
        expect(page).to have_content '2008-12-24'
        expect(page).to have_content '120'  
        expect(page).to have_content '125' 
      end
    end

    it 'e não ve dos outros' do
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                      full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                        email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                        wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                        fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                        sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
      dish = Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                        calories: 174, restaurant: restaurant)
      dish_portion = DishPortion.create!(description: 'Uma pessoa', price: 125.12, dish: dish)
      second_admin = Admin.create!(name: 'Carlos', last_name: 'Martinez', cpf: '79404816060', 
                                  email: 'carlos@email.com', password: '123456789123')
      second_restaurant = Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 28176493000134, 
                                            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                                            email: 'contato@mcdonalsp.com' ,telephone_number: 11999695714, admin: second_admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                                  wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                                  fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                                  sun_open: '08:00', sun_close: '18:00', restaurant: second_restaurant )
    
      login_as(second_admin)
      visit dish_dish_portion_path(dish, dish_portion.id)
      
      expect(current_path).to eq root_path
    end
  end
end