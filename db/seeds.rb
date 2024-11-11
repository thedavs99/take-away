# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#   
admin = Admin.create!(name: 'Juan', last_name: 'Martinez', cpf: '66423165092', 
email: 'juan@email.com', password: '123456789123')
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

tag_a = Tag.create!(description: 'Com glutem', restaurant: restaurant)
tag_b = Tag.create!(description: 'Sem azucar', restaurant: restaurant)
Tagging.create!(dish: dish_a, tag: tag_a)
Tagging.create!(dish: dish_a, tag: tag_b)

menu = Menu.create!(name: 'Almoço', restaurant: restaurant)
Item.create!(menu: menu, beverage: beverage_a)
Item.create!(menu: menu, dish: dish_a)
Item.create!(menu: menu, beverage: beverage_b)
Item.create!(menu: menu, dish: dish_b)

beverage_portion = BeveragePortion.create!(description: 'Lata', price: 20, beverage: beverage_a)
dish_portion = DishPortion.create!(description: 'Uma pessoa', price: 125, dish: dish_b)
DishPortion.create!(description: 'Duas pessoas', price: 230, dish: dish_b)
BeveragePortion.create!(description: '1.5L', price: 30, beverage: beverage_a)
DishPortion.create!(description: 'uma pessoa', price: 100, dish: dish_a)
BeveragePortion.create!(description: '300ml', price: 15, beverage: beverage_b)
orderable_beverage = OrderableBeverage.create!(quantity: 1, beverage_portion: beverage_portion)
orderable_dish = OrderableDish.create!(quantity: 1, dish_portion: dish_portion)
orderable_beverage_b = OrderableBeverage.create!(quantity: 2, beverage_portion: beverage_portion)
orderable_dish_b = OrderableDish.create!(quantity: 2, dish_portion: dish_portion)

Order.create!(name: 'Julia', email: 'julia@email.com', cpf: '50514139005', orderable_beverages: [orderable_beverage], orderable_dishes: [orderable_dish], restaurant: restaurant)

Order.create!(name: 'Carlos', email: 'carlos@email.com', cpf: '87067249066', orderable_beverages: [orderable_beverage_b], orderable_dishes: [orderable_dish_b], restaurant: restaurant)
Worker.create!(email: 'luna@email.com', cpf: '59868419050', restaurant: restaurant)
Worker.create!(email: 'carola@email.com', cpf: '83521649024', restaurant: restaurant)
User.create!(name: 'Luna', last_name: 'Garcia', cpf: '59868419050', 
email: 'luna@email.com', password: '123456789123')
