require 'rails_helper'

describe 'Administrador registra um pedido' do
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
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

    login_as(admin)
    visit root_path
    click_on 'Almoço'
    within("##{dish_portion.id}-dish") do
      fill_in 'quantity', with: 1
      click_on 'Adicionar ao pedido'
    end
    within("##{beverage_portion.id}-beverage") do
      fill_in 'quantity', with: 1
      click_on 'Adicionar ao pedido'
    end
    click_on 'Enviar Pedido'
    fill_in 'Nome', with: 'Carlos Suarez'
    fill_in 'E-mail', with: 'carlos@email.com'
    fill_in 'Telefone', with: '11923451234'
    fill_in 'CPF', with: '04337878050'
    click_on 'Enviar'

    expect(page).to have_content 'Pedido: ABC12345'
    expect(page).to have_content 'Carlos Suarez'
    expect(page).to have_content 'carlos@email.com'
    expect(page).to have_content '11923451234'
    expect(page).to have_content '04337878050'
    expect(page).to have_content 'Status: Aguardando confirmação da cozinha'
    expect(page).to have_content 'Coca-Cola'
    expect(page).to have_content 'Lata'
    expect(page).to have_content '20 x 1'
    expect(page).to have_content 'Ragú'
    expect(page).to have_content 'Uma pessoa'
    expect(page).to have_content '125 x 1'
    expect(page).to have_content 'Total: 145'
  end

  it 'e os campos telefone o email devem ser obrigatorios' do
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

    login_as(admin)
    visit root_path
    click_on 'Almoço'
    within("##{dish_portion.id}-dish") do
      fill_in 'quantity', with: 1
      click_on 'Adicionar ao pedido'
    end
    within("##{beverage_portion.id}-beverage") do
      fill_in 'quantity', with: 1
      click_on 'Adicionar ao pedido'
    end
    click_on 'Enviar Pedido'
    fill_in 'Nome', with: 'Carlos Suarez'
    fill_in 'E-mail', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'CPF', with: '04337878050'
    click_on 'Enviar'

    expect(page).to have_content 'Error ao criar o pedido'
    expect(page).to have_content 'Por favor, preencha o campo de telefone ou o campo de e-mail.'
  end
end