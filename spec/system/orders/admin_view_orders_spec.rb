require 'rails_helper'

describe 'Administrador visualiza os pedidos' do
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
    dish_b = Dish.create!(name: 'Ragú', description: 'suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
                calories: 177, restaurant: restaurant)
    beverage_a = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
    menu = Menu.create!(name: 'Almoço', restaurant: restaurant)
    Item.create!(menu: menu, beverage: beverage_a)
    Item.create!(menu: menu, dish: dish_b)
    beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage_a)
    dish_portion = DishPortion.create!(description: 'Uma pessoa', price: 125, dish: dish_b)
    orderable_beverage = OrderableBeverage.create!(quantity: 1, beverage_portion: beverage_portion)
    orderable_dish = OrderableDish.create!(quantity: 1, dish_portion: dish_portion)
    orderable_beverage_b = OrderableBeverage.create!(quantity: 2, beverage_portion: beverage_portion)
    orderable_dish_b = OrderableDish.create!(quantity: 2, dish_portion: dish_portion)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
    Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], orderable_dishes: [orderable_dish], restaurant: restaurant)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC34567')
    Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage_b], orderable_dishes: [orderable_dish_b], restaurant: restaurant)


    login_as(admin)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content 'Pedido: ABC12345'
    expect(page).to have_content 'Pedido: ABC34567'
  end
end