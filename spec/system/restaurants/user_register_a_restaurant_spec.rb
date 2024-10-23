require 'rails_helper'

describe 'Usuario cadastra um fornecedor' do
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


  it 'com dados incompletos' do
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
    fill_in 'Razão Social', with: 'Mc Donalds Enterprise SP'
    fill_in 'Nome Fantasia', with: 'Mc Donalds'
    fill_in 'CNPJ', with: CNPJ.generate
    fill_in 'Telefone', with: '11 93059 1238'
    fill_in 'E-mail', with: 'contato@mcdonald.com'
    fill_in 'Endereço Completo', with: 'Rua Antonio Miguel, 99'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Restaurante cadastrado'
  end
end