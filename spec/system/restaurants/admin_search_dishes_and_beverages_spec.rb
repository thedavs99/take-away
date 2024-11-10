require 'rails_helper'

describe 'Administrador busca bebidas e pratos' do
  it 'a partir do menu' do
    # Arrange
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                            email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                            wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                            fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                            sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

    # Act
    login_as(admin, scope: :admin)
    visit root_path

    # Assert
    within 'nav' do
      expect(page).to have_field 'Opcções disponíveis'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit root_path
    # Assert
    within 'nav' do
      expect(page).not_to have_field 'opcções disponíveis'
      expect(page).not_to have_button 'Buscar'
    end
  end

  it 'a encontra pratos' do
    # Arrange
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                            email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                            wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                            fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                            sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

    Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                            calories: 174, restaurant: restaurant)

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    fill_in 'Opcções disponíveis', with: 'Risotto'
    click_on 'Buscar'

    # Assert

    expect(page).to have_content "Resultados da Busca por: Risotto"
    expect(page).to have_content 'Opções encontradas: 1'
    expect(page).to have_content "Risotto"
  end

  it 'e encontra tanto bebidas como pratos' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                            email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                            wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                            fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                            sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

    Dish.create!(name: 'Arroz com frango e Coca-Cola', description: 'Preparado com coca-cola, vinho vemelho, e carne.', 
                            calories: 174, restaurant: restaurant)
    Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    fill_in 'Opcções disponíveis', with: 'Coca-Cola'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Resultados da Busca por: Coca-Cola"
    expect(page).to have_content 'Opções encontradas: 2'
    expect(page).to have_content "Arroz com frango e Coca-Cola"
    expect(page).to have_content "Coca-Cola"
  end

  it 'e ve detalhes' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                            email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                            wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                            fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                            sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

    Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                            calories: 174, restaurant: restaurant)

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    fill_in 'Opcções disponíveis', with: 'Risotto'
    click_on 'Buscar'
    click_on 'Risotto'

    # Assert
    expect(page).to have_content 'Prato: Risotto'
    expect(page).to have_content 'Descrição: Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.'
    expect(page).to have_content 'Calorias: 174'
  end

  it 'e va a tela de editar' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                            email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                            wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                            fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                            sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

    Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                            calories: 174, restaurant: restaurant)

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    fill_in 'Opcções disponíveis', with: 'Risotto'
    click_on 'Buscar'
    click_on 'Editar'

    # Assert
    expect(page).to have_field('Nome', with: 'Risotto')
    expect(page).to have_field('Descrição', with: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.')
    expect(page).to have_field('Calorias', with: '174.0')
  end

  it 'a encontra pratos a traves de tags' do
    # Arrange
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                            full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                            email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                            wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                            fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                            sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

    dish = Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                            calories: 174, restaurant: restaurant)
    tag = Tag.create!(description: 'Com glutem', restaurant: restaurant)
    Tagging.create(tag: tag, dish: dish)

    # Act
    login_as(admin, scope: :admin)
    visit root_path
    fill_in 'Opcções disponíveis', with: 'Com glutem'
    click_on 'Buscar'

    # Assert

    expect(page).to have_content "Resultados da Busca por: Com glutem"
    expect(page).to have_content 'Opções encontradas: 1'
    expect(page).to have_content "Risotto"
  end

end