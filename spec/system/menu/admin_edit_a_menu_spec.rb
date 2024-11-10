require 'rails_helper'

describe 'Administrador ve detalhes de um cardápio' do
  it 'com sucesso' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
    dish_a = Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                calories: 174, restaurant: restaurant)
    dish_b = Dish.create!(name: 'Ragú', description: 'suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
                calories: 177, restaurant: restaurant)
    beverage_a = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
    beverage_b = Beverage.create!(name: 'Caipirinha', description: 'Coquetel brasileiro, de origem paulista.',
    calories: 99, restaurant: restaurant)
    menu = Menu.create!(name: 'Almoço', restaurant: restaurant)
    Item.create!(menu: menu, beverage: beverage_a)
    Item.create!(menu: menu, dish: dish_a)
    Item.create!(menu: menu, beverage: beverage_b)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Almoço'
    click_on 'Editar'
    select 'Risotto', from: 'Prato'
    select 'Ragú', from: 'Prato'
    click_on 'Enviar'

    expect(page).to have_content 'Cardápio de Restaurante atualizado'
  end
end