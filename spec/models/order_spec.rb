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
end
