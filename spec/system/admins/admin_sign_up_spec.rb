require 'rails_helper'

describe 'Administrador se cadastra' do
  it 'com sucesso' do
    # Arrange
    # Act
    visit root_path
    click_on 'Administrador'
    click_on 'Crie sua conta!'
    fill_in 'Nome', with: 'David'
    fill_in 'Sobrenome', with: 'Martinez'
    fill_in 'CPF', with: '12223111190'
    fill_in 'E-mail', with: 'david@email.com'
    fill_in 'Senha', with: '123456789123'
    fill_in 'Confirme sua senha', with: '123456789123'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'david@email.com'
    expect(page).to have_button 'Sair'
    admin = Admin.last
    expect(admin.name).to eq 'David'
  end

  it 'e vê tela de cadastro de restaurante' do
    # Arrange
    # Act
    visit root_path
    click_on 'Administrador'
    click_on 'Crie sua conta!'
    fill_in 'Nome', with: 'David'
    fill_in 'Sobrenome', with: 'Martinez'
    fill_in 'CPF', with: '12223111190'
    fill_in 'E-mail', with: 'david@email.com'
    fill_in 'Senha', with: '123456789123'
    fill_in 'Confirme sua senha', with: '123456789123'
    click_on 'Criar conta'

    # Assert
    expect(current_path).to eq new_restaurant_path  
  end

end