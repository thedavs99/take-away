require 'rails_helper'

describe 'Usuario vê seu restaurante' do
  it 'é não ve acceso a seu restaurante' do
    # Arrange
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                        email: 'david@email.com', password: '123456789123')

    # Act
    login_as(admin)
    visit root_path

    # Assert
    within 'nav' do
      expect(page).not_to have_link 'Meu Restaurante'
    end
  end

  it 'com sucesso' do
    # Arrange
    admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                        email: 'david@email.com', password: '123456789123')
    restaurant = Restaurant.create!(corporate_name: "McDonald's São Paulo", brand_name: "McDonald's", cnpj: 26219781000101, 
                        full_address: 'Rua Henrique Schaumann, 80/124 - Cerqueira César, São Paulo - SP, 05413-010', 
                        email: 'contato@mcdonaldsp.com' ,telephone_number: 11999695710, admin: admin)
    # Act
    login_as(admin)
    visit root_path
    click_on 'Meu Restaurante'


    # Assert
    expect(current_path).to eq restaurant_path(restaurant.id)
    expect(page).to have_content("Restaurante: McDonald's")
    expect(page).to have_content("Razão Social: McDonald's São Paulo")
    expect(page).to have_content("CNPJ: 26219781000101")
    expect(page).to have_content('Endereço Completo: Rua Henrique Schaumann, 80/124 - Cerqueira César, São Paulo - SP, 05413-010')
    expect(page).to have_content('E-mail: contato@mcdonaldsp.com')
    expect(page).to have_content('Telefone: 11999695710')
  end
end