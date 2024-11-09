require 'rails_helper'

describe 'Administrador visita tela inicial' do
  it 'e vê o nome da app' do
    # Arrange

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Pá Levar')
    expect(page).to have_link('Pá Levar', href: root_path)
  end

  it 'e vé link de login' do
    # Arrange

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Entrar')
  end
end