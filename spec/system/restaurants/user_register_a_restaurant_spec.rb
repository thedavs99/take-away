require 'rails_helper'

describe 'Usuario cadastra um restaurante' do
  it 'ao fazer login' do
    # Arrange
    Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    # Act
    visit root_path
    click_on 'Entrar'

    within 'form' do
      fill_in 'E-mail', with: 'david@email.com'
      fill_in 'Senha', with: '123456789123'
      click_on 'Entrar'
    end

    # Assert
    expect(current_path).to eq new_restaurant_path
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço Completo')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Telefone')
  end


  it 'com sucesso' do
    # Arrange
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    # Act
    login_as(admin)
    visit root_path

    fill_in 'Razão Social', with: 'Mc Donalds Enterprise SP'
    fill_in 'Nome Fantasia', with: 'Mc Donalds'
    fill_in 'CNPJ', with: 26219781000101
    fill_in 'Telefone', with: '11930591238'
    fill_in 'E-mail', with: 'contato@mcdonald.com'
    fill_in 'Endereço Completo', with: 'Rua Antonio Miguel, 99'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Restaurante cadastrado'
    expect(page).to have_content 'Restaurante: Mc Donalds'
    expect(page).to have_content 'Telefone: 11930591238'
    expect(page).to have_content 'E-mail: contato@mcdonald.com'
  end

  it 'com dados incompletos' do
    # Arrange
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
    email: 'david@email.com', password: '123456789123')
    # Act
    login_as(admin)
    visit root_path
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Endereço Completo', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Restaurante não cadastrado'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço Completo não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end

  it 'Usuario cadastra segundo restaurante' do
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)

    login_as(admin)
    visit new_restaurant_path

    expect(current_path).to eq(restaurant_path(restaurant.id))
  end
end