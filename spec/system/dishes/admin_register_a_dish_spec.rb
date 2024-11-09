require 'rails_helper'

describe 'Administrador cadastra um prato' do
  it 'da tela de inicio' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
    tag = Tag.create!(description: 'Com glutem', restaurant: restaurant)

    login_as(admin)
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Cadastrar'

    expect(page).to have_content 'Cadastrar Prato'
    within '#dish' do
      expect(page).to have_field('Nome')  
      expect(page).to have_field('Características') 
      expect(page).to have_field('Descrição') 
      expect(page).to have_field('Calorias')
    end
  end

  it 'com sucesso' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
    tag = Tag.create!(description: 'Com glutem', restaurant: restaurant)

    login_as(admin)
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Cadastrar'
    within '#dish' do
      fill_in 'Nome', with: 'Risotto'
      fill_in 'Descrição', with: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.'
      fill_in 'Calorias', with: '174' 
      click_on 'Enviar'      
    end

    expect(current_path).to eq dishes_path
  end

  it 'com dados incompletos' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
    tag = Tag.create!(description: 'Com glutem', restaurant: restaurant)

    login_as(admin)
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Cadastrar'
    within '#dish' do
      fill_in 'Nome', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'Calorias', with: ''
      click_on 'Enviar'      
    end
    
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Calorias não pode ficar em branco'
  end

  it 'Adiciona imagem e é criado com status' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)
    restaurant_schedule = RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )
    Tag.create!(description: 'Com glutem', restaurant: restaurant)

    login_as(admin)
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Cadastrar'
    within '#dish' do
      fill_in 'Nome', with: 'Risotto'
      fill_in 'Descrição', with: 'Preparado com caldo de legumes, vinho branco, manteiga e queijo parmesão ralado.'
      fill_in 'Calorias', with: '174' 
      select 'Com glutem', from: 'Características'
      attach_file 'Foto', Rails.root.join('spec', 'support', 'risotto.jpeg')
      click_on 'Enviar'     
    end
    click_on 'Risotto'

    expect(page).to have_css('img[src*="risotto.jpeg"]')
    expect(page).to have_content('Status: Ativo')
    expect(page).to have_content('Com glutem')
  end
end