require 'rails_helper'

describe 'Orders API' do
  context 'GET /api/v1/restaurant/ABC123/orders' do
    it 'success' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
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
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC34567')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], orderable_dishes: [orderable_dish], restaurant: restaurant)

      get '/api/v1/restaurants/ABC123/orders'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response[0]["Codigo"]).to eq 'ABC12345'
      expect(json_response[1]["Codigo"]).to eq 'ABC34567'
      expect(json_response[0]["Status"]).to eq 'Aguardando confirmação da cozinha'
      expect(json_response[1]["Status"]).to eq 'Aguardando confirmação da cozinha'
      expect(json_response[0].keys).not_to include 'created_at'
      expect(json_response[0].keys).not_to include 'updated_at'
      expect(json_response[1].keys).not_to include 'created_at'
      expect(json_response[1].keys).not_to include 'updated_at'
    end
  
    it 'return empty if the ir no order' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
              wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
              fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
              sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)

      get '/api/v1/restaurants/ABC123/orders'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'fail if restaurant not found' do
      get '/api/v1/restaurants/ABC123/orders'

      expect(response.status).to eq 404
    end

    it 'and raise internal error' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
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
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC34567')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], orderable_dishes: [orderable_dish], restaurant: restaurant)

      allow(Restaurant).to receive(:find_by).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/restaurants/ABC123/orders'

      expect(response.status).to eq 500
    end
  end

  context 'GET /api/v1/restaurant/ABC123/orders?status=' do
    it 'Aguardando_confirmacao_da_cozinha success' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
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
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC34567')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :in_preparation)

      get '/api/v1/restaurants/ABC123/orders?status=Aguardando_confirmacao_da_cozinha'

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response[0]["Codigo"]).to eq 'ABC12345'
      expect(json_response[0]["Status"]).to eq 'Aguardando confirmação da cozinha'
    end

    it 'Em_preparacao success' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
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
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC34567')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :in_preparation)

      get '/api/v1/restaurants/ABC123/orders?status=Em_preparacao'

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response[0]["Codigo"]).to eq 'ABC34567'
      expect(json_response[0]["Status"]).to eq 'Em preparação'
    end

    it 'Cancelado success' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
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
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC34567')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :in_preparation)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC23456')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :canceled)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC45678')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :canceled)
          

      get '/api/v1/restaurants/ABC123/orders?status=Cancelado'

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["Codigo"]).to eq 'ABC23456'
      expect(json_response[0]["Status"]).to eq 'Cancelado'
      expect(json_response[1]["Codigo"]).to eq 'ABC45678'
      expect(json_response[1]["Status"]).to eq 'Cancelado'
    end

    it 'Pronto success' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
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
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC34567')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :in_preparation)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC23456')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :ready)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC45678')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :ready)
          

      get '/api/v1/restaurants/ABC123/orders?status=Pronto'

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["Codigo"]).to eq 'ABC23456'
      expect(json_response[0]["Status"]).to eq 'Pronto'
      expect(json_response[1]["Codigo"]).to eq 'ABC45678'
      expect(json_response[1]["Status"]).to eq 'Pronto'
    end

    it 'Entregue success' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
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
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC34567')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :in_preparation)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC23456')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :delivered)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC45678')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :delivered)
          

      get '/api/v1/restaurants/ABC123/orders?status=Entregue'

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["Codigo"]).to eq 'ABC23456'
      expect(json_response[0]["Status"]).to eq 'Entregue'
      expect(json_response[1]["Codigo"]).to eq 'ABC45678'
      expect(json_response[1]["Status"]).to eq 'Entregue'
    end

    it 'Show all orders when empty' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
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
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC34567')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :in_preparation)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC23456')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :canceled)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC45678')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :delivered)
        

      get '/api/v1/restaurants/ABC123/orders?status=Pronto'

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 4
      expect(json_response[0]["Codigo"]).to eq 'ABC12345'
      expect(json_response[1]["Codigo"]).to eq 'ABC34567'
      expect(json_response[2]["Codigo"]).to eq 'ABC23456'
      expect(json_response[3]["Codigo"]).to eq 'ABC45678'
      expect(json_response[0]["Status"]).to eq 'Aguardando confirmação da cozinha'
      expect(json_response[1]["Status"]).to eq 'Em preparação'
      expect(json_response[2]["Status"]).to eq 'Cancelado'
      expect(json_response[3]["Status"]).to eq 'Entregue'
    end

    it 'Show all orders when invalid params' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
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
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC34567')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :in_preparation)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC23456')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :canceled)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC54321')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :ready)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC45678')
      Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], 
                    orderable_dishes: [orderable_dish], restaurant: restaurant, status: :delivered)
        

      get '/api/v1/restaurants/ABC123/orders?status=Esperando_confir_na_co'

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 5
      expect(json_response[0]["Codigo"]).to eq 'ABC12345'
      expect(json_response[1]["Codigo"]).to eq 'ABC34567'
      expect(json_response[2]["Codigo"]).to eq 'ABC23456'
      expect(json_response[3]["Codigo"]).to eq 'ABC54321'
      expect(json_response[4]["Codigo"]).to eq 'ABC45678'
      expect(json_response[0]["Status"]).to eq 'Aguardando confirmação da cozinha'
      expect(json_response[1]["Status"]).to eq 'Em preparação'
      expect(json_response[2]["Status"]).to eq 'Cancelado'
      expect(json_response[3]["Status"]).to eq 'Pronto'
      expect(json_response[4]["Status"]).to eq 'Entregue'
    end

    it 'return empty if the ir no order' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
              wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
              fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
              sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)

      get '/api/v1/restaurants/ABC123/orders?status=Pronto'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end

  context 'GET /api/v1/restaurant/ABC123/orders/ABC12345' do
    it 'success' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
              wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
              fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
              sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
      dish = Dish.create!(name: 'Ragú', description: 'Suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
          calories: 177, restaurant: restaurant)
      beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
      beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)
      dish_portion = DishPortion.create!(description: 'Uma pessoa', price: 125, dish: dish)
      dish_portion_b = DishPortion.create!(description: 'Tres pessoas', price: 455, dish: dish)
      orderable_beverage = OrderableBeverage.create!(quantity: 2, beverage_portion: beverage_portion)
      orderable_dishes = []
      orderable_dishes << OrderableDish.create!(quantity: 1, dish_portion: dish_portion)
      orderable_dishes << OrderableDish.create!(quantity: 1, dish_portion: dish_portion_b)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], orderable_dishes: orderable_dishes, restaurant: restaurant)

      get '/api/v1/restaurants/ABC123/orders/ABC12345'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["code"]).to eq 'ABC12345'
      expect(json_response["status"]).to eq 'Aguardando confirmação da cozinha'
      expect(json_response["name"]).to eq 'Julia'
      expect(json_response["email"]).to eq 'julia@email.com'
      expect(json_response["cpf"]).to eq '12223111190'
      expect(json_response["created_at"]).to eq I18n.l(Date.today)
      expect(json_response["items"]["dishes"][0]["name"]).to eq 'Ragú'
      expect(json_response["items"]["dishes"][0]["portion"]).to eq 'Uma pessoa'
      expect(json_response["items"]["dishes"][0]["price"]).to eq 125
      expect(json_response["items"]["dishes"][0]["quantity"]).to eq 1
      expect(json_response["items"]["beverages"][0]["name"]).to eq 'Coca-Cola'
      expect(json_response["items"]["beverages"][0]["portion"]).to eq 'Lata'
      expect(json_response["items"]["beverages"][0]["price"]).to eq 20
      expect(json_response["items"]["beverages"][0]["quantity"]).to eq 2
      expect(json_response["items"]["dishes"][1]["name"]).to eq 'Ragú'
      expect(json_response["items"]["dishes"][1]["portion"]).to eq 'Tres pessoas'
      expect(json_response["items"]["dishes"][1]["price"]).to eq 455
      expect(json_response["items"]["dishes"][1]["quantity"]).to eq 1
      expect(json_response["total"]).to eq 620
    end

    it 'fail if restaurant not found' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
              wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
              fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
              sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)

      get '/api/v1/restaurants/ABC123/orders/ABC12345'

      expect(response.status).to eq 404
    end
  end

  context 'POST /api/v1/restaurant/ABC123/orders/ABC12345/in_preparation' do
    it 'success' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
              wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
              fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
              sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
      dish = Dish.create!(name: 'Ragú', description: 'Suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
          calories: 177, restaurant: restaurant)
      beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
      beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)
      dish_portion = DishPortion.create!(description: 'Uma pessoa', price: 125, dish: dish)
      dish_portion_b = DishPortion.create!(description: 'Tres pessoas', price: 455, dish: dish)
      orderable_beverage = OrderableBeverage.create!(quantity: 2, beverage_portion: beverage_portion)
      orderable_dishes = []
      orderable_dishes << OrderableDish.create!(quantity: 1, dish_portion: dish_portion)
      orderable_dishes << OrderableDish.create!(quantity: 1, dish_portion: dish_portion_b)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], orderable_dishes: orderable_dishes, restaurant: restaurant)

      post '/api/v1/restaurants/ABC123/orders/ABC12345/in_preparation'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["status"]).to eq 'Em preparação'
    end

    it 'fail when order not found' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
              wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
              fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
              sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)

      beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
      beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)

      orderable_beverage = OrderableBeverage.create!(quantity: 2, beverage_portion: beverage_portion)

      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], restaurant: restaurant)

      post '/api/v1/restaurants/ABC123/orders/11111111/in_preparation'

      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Pedido não encontrado'
    end

    it 'fail when order status is not on awaiting_kitchen_confirmation' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
              wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
              fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
              sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
      beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
      beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)
      orderable_beverage = OrderableBeverage.create!(quantity: 2, beverage_portion: beverage_portion)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', 
                  orderable_beverages: [orderable_beverage], restaurant: restaurant, status: :ready)

      post '/api/v1/restaurants/ABC123/orders/ABC12345/in_preparation'

      expect(response.status).to eq 422
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Só é possivel aplicar a pedidos Aguardando confirmação da cozinha'
    end
  end

  context 'POST /api/v1/restaurant/ABC123/orders/ABC12345/ready' do
    it 'success' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
              wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
              fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
              sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
      dish = Dish.create!(name: 'Ragú', description: 'Suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
          calories: 177, restaurant: restaurant)
      beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
      beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)
      dish_portion = DishPortion.create!(description: 'Uma pessoa', price: 125, dish: dish)
      dish_portion_b = DishPortion.create!(description: 'Tres pessoas', price: 455, dish: dish)
      orderable_beverage = OrderableBeverage.create!(quantity: 2, beverage_portion: beverage_portion)
      orderable_dishes = []
      orderable_dishes << OrderableDish.create!(quantity: 1, dish_portion: dish_portion)
      orderable_dishes << OrderableDish.create!(quantity: 1, dish_portion: dish_portion_b)
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], orderable_dishes: orderable_dishes, restaurant: restaurant, status: :in_preparation)

      post '/api/v1/restaurants/ABC123/orders/ABC12345/ready'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["status"]).to eq 'Pronto'
    end

    it 'fail when order not found' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
              wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
              fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
              sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)

      beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
      beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)

      orderable_beverage = OrderableBeverage.create!(quantity: 2, beverage_portion: beverage_portion)

      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', orderable_beverages: [orderable_beverage], restaurant: restaurant)

      post '/api/v1/restaurants/ABC123/orders/11111111/ready'

      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Pedido não encontrado'
    end

    it 'fail when order status is not on in_preparation' do
        allow(SecureRandom).to receive(:alphanumeric).and_return('ABC123')
        admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
        email: 'david@email.com', password: '123456789123')
        restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
        RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
        beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
        beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage)
        orderable_beverage = OrderableBeverage.create!(quantity: 2, beverage_portion: beverage_portion)
        allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
        Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '12223111190', 
                    orderable_beverages: [orderable_beverage], restaurant: restaurant, status: :ready)
  
        post '/api/v1/restaurants/ABC123/orders/ABC12345/ready'
  
        expect(response.status).to eq 422
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq 'Só é possivel aplicar a pedidos em preparação'
      end
  end
end