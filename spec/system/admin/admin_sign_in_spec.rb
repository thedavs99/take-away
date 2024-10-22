require 'rails_helper'

describe 'Usuário se auntentica' do
  it 'com sucesso' do
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
    within('nav') do
      expect(page).to have_button 'Sair'
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_content 'David Martinez - david@email.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end

  it 'e faz logout' do
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
    click_on 'Sair'  

    # Assert
    expect(page).not_to have_button 'Sair'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'David Martinez - david@email.com'
    expect(page).not_to have_content 'Login efetuado com sucesso.'    
  end
end