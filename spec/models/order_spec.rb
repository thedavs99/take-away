require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'CPF deve ser valido' do
    first_order = Order.new(cpf: '123456789123')
    first_order.valid?
    second_order = Order.new(cpf: '09275944040')
    second_order.valid?

    expect(first_order.errors.include?(:cpf)).to be true
    expect(second_order.errors.include?(:cpf)).to be false
  end

  it 'E-mail deve ser valido' do
    order = Order.new(email: 'davidhotmailcom')

    order.valid?

    expect(order.errors.include?(:email)).to be true
  end

  it 'Telefone deve ser um campo com 10 ou 11 caracteres.' do
    first_order = Order.new(telephone_number: 111111111)
    first_order.valid?
    second_order = Order.new(telephone_number: 1111111111)
    second_order.valid?
    third_order = Order.new(telephone_number: 11111111111)
    third_order.valid?
    fourd_order = Order.new(telephone_number: 111111111111)
    fourd_order.valid?

    expect(first_order.errors.include?(:telephone_number)).to be true
    expect(second_order.errors.include?(:telephone_number)).to be false
    expect(third_order.errors.include?(:telephone_number)).to be false
    expect(fourd_order.errors.include?(:telephone_number)).to be true      
  end
end
