require 'rails_helper'

describe 'Administrador cadastra um cardápio' do
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
    Dish.create!(name: 'Risotto', description: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.', 
                calories: 174, restaurant: restaurant)
    Dish.create!(name: 'Ragú', description: 'suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
                calories: 177, restaurant: restaurant)
    Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
    Beverage.create!(name: 'Caipirinha', description: 'Coquetel brasileiro, de origem paulista.',
    calories: 99, restaurant: restaurant)

    login_as(admin, scope: :admin)
    visit(root_path)
    click_on 'Cadastrar cardápio'
    fill_in 'Nome', with: 'Almoço Executivo'
    select 'Risotto', from: 'Prato'
    select 'Ragú', from: 'Prato'
    select 'Caipirinha', from: 'Bebida'
    select 'Coca-Cola', from: 'Bebida'
    click_on 'Enviar'

    expect(page).to have_content 'Almoço Executivo'
  end

  it 'e o nome não pode estar vazio' do
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
    Dish.create!(name: 'Ragú', description: 'suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
                calories: 177, restaurant: restaurant)
    Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
    Beverage.create!(name: 'Caipirinha', description: 'Coquetel brasileiro, de origem paulista.',
    calories: 99, restaurant: restaurant)


    login_as(admin, scope: :admin)
    visit(root_path)
    click_on 'Cadastrar cardápio'
    fill_in 'Nome', with: ''
    select 'Risotto', from: 'Prato'
    select 'Ragú', from: 'Prato'
    select 'Caipirinha', from: 'Bebida'
    select 'Coca-Cola', from: 'Bebida'
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possivel realizar o cadastro'
    expect(page).to have_content 'Nome não pode ficar em branco'   
  end

  it 'e não pode ter o mesmo nome' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)
    Menu.create!(name: 'Almoço', restaurant: restaurant)

    login_as(admin, scope: :admin)
    visit(root_path)
    click_on 'Cadastrar cardápio'
    fill_in 'Nome', with: 'Almoço'
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possivel realizar o cadastro'
    expect(page).to have_content 'Nome já está em uso'   
  end

  it 'e permite cadastrar cardápios com o mesmo nome em restaurantes diferentes' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)

    second_admin = Admin.create!(name: 'Carlos', last_name: 'Martinez', cpf: '79404816060', 
                email: 'carlos@email.com', password: '123456789123')
    second_restaurant = Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 28176493000134, 
              full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
              email: 'contato@mcdonalsp.com' ,telephone_number: 11999695714, admin: second_admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                  wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                  fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                  sun_open: '08:00', sun_close: '18:00', restaurant: second_restaurant )
    Menu.create!(name: 'Almoço', restaurant: second_restaurant)
    
    login_as(admin, scope: :admin)
    visit(root_path)
    click_on 'Cadastrar cardápio'
    fill_in 'Nome', with: 'Almoço'
    click_on 'Enviar'

     
    expect(page).to have_content 'Cardápio de Restaurante cadastrado' 
    expect(page).to have_content 'Almoço' 
  end

  it 'Sazonal' do    
    travel_to(Time.zone.local(2024, 12, 15, 00, 00, 00))
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
    Dish.create!(name: 'Ragú', description: 'suculento molho à base de carne cozida. A palavra é de origem francesa, mas a receita foi criada na Itália.',
                calories: 177, restaurant: restaurant)
    Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante carbonatado vendido em lojas.', calories: 80, restaurant: restaurant)
    Beverage.create!(name: 'Caipirinha', description: 'Coquetel brasileiro, de origem paulista.',
    calories: 99, restaurant: restaurant)

    login_as(admin, scope: :admin)
    visit(root_path)
    click_on 'Cadastrar cardápio'
    fill_in 'Nome', with: 'Almoço Executivo'
    select 'Risotto', from: 'Prato'
    select 'Ragú', from: 'Prato'
    select 'Caipirinha', from: 'Bebida'
    select 'Coca-Cola', from: 'Bebida'
    fill_in 'Data de Inicio', with: '2024-10-20'
    fill_in 'Data de Fechamento', with: '2024-12-20'
    click_on 'Enviar'
     
    expect(page).to have_content 'Cardápio de Restaurante cadastrado' 
    expect(page).to have_content 'Almoço Executivo' 
  end

  it 'E data de fechamento não pode ficar em branco se tem data de inicio' do    
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant)

    login_as(admin, scope: :admin)
    visit(root_path)
    click_on 'Cadastrar cardápio'
    fill_in 'Nome', with: 'Almoço Executivo'
    fill_in 'Data de Inicio', with: '2024-10-20'
    fill_in 'Data de Fechamento', with: ''
    click_on 'Enviar'
     
    expect(page).to have_content 'Data de Fechamento não pode ficar em branco, se houver data de início'  
  end
end