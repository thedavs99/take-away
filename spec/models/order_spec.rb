require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'CPF deve ser valido' do
    first_order = Order.new(cpf: '123456789123')
    first_order.valid?
    second_order = Order.new(cpf: '09275944040')
    second_order.valid?

    expect(first_order.errors.include?(:cpf)).to be true
    expect(second_order.errors.include?(:cpf)).to be false
  end

  it 'E-mail deve ser valido' do
    order = Order.new(email: 'davidhotmailcom')

    order.valid?

    expect(order.errors.include?(:email)).to be true
  end

  it 'Telefone deve ser um campo com 10 ou 11 caracteres.' do
    first_order = Order.new(telephone_number: 111111111)
    first_order.valid?
    second_order = Order.new(telephone_number: 1111111111)
    second_order.valid?
    third_order = Order.new(telephone_number: 11111111111)
    third_order.valid?
    fourd_order = Order.new(telephone_number: 111111111111)
    fourd_order.valid?

    expect(first_order.errors.include?(:telephone_number)).to be true
    expect(second_order.errors.include?(:telephone_number)).to be false
    expect(third_order.errors.include?(:telephone_number)).to be false
    expect(fourd_order.errors.include?(:telephone_number)).to be true      
  end
  
  it 'e codigo deve ser unico' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
            email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
            wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
            fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
            sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
    dish = Dish.create!(name: 'Ragú', description: 'suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
        calories: 177, restaurant: restaurant)
    beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
    beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)
    dish_portion = DishPortion.create!(description: 'Uma pessoa', price: 125, dish: dish)
    orderable_beverage = OrderableBeverage.create!(quantity: 1, beverage_portion: beverage_portion)
    orderable_dish = OrderableDish.create!(quantity: 1, dish_portion: dish_portion)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
    Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], orderable_dishes: [orderable_dish], restaurant: restaurant)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
    second_order = Order.new(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], orderable_dishes: [orderable_dish], restaurant: restaurant)


    second_order.valid?
        
    expect(second_order.errors.include?(:code)).to be true
  end

  it 'e não pode ser cancelado sem descrição' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
            email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
            wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
            fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
            sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
    dish = Dish.create!(name: 'Ragú', description: 'suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
        calories: 177, restaurant: restaurant)
    beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
    beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)
    dish_portion = DishPortion.create!(description: 'Uma pessoa', price: 125, dish: dish)
    orderable_beverage = OrderableBeverage.create!(quantity: 1, beverage_portion: beverage_portion)
    orderable_dish = OrderableDish.create!(quantity: 1, dish_portion: dish_portion)
    order = Order.new(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], orderable_dishes: [orderable_dish], restaurant: restaurant, status: :canceled)

    order.valid?
        
    expect(order.errors.include?(:status)).to be true
  end

  it 'e não pode adicionar descrição a pedidos não cancelados' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
            email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
            wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
            fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
            sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
    dish = Dish.create!(name: 'Ragú', description: 'suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
        calories: 177, restaurant: restaurant)
    beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
    beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)
    dish_portion = DishPortion.create!(description: 'Uma pessoa', price: 125, dish: dish)
    orderable_beverage = OrderableBeverage.create!(quantity: 1, beverage_portion: beverage_portion)
    orderable_dish = OrderableDish.create!(quantity: 1, dish_portion: dish_portion)
    order = Order.new(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], orderable_dishes: [orderable_dish], restaurant: restaurant, status: :ready, description: 'Acabou coca-cola')

    order.valid?
        
    expect(order.errors.include?(:description)).to be true
  end
end
