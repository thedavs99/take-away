require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid?" do
    it 'campo não pode estar vacio' do
      user = User.new(email: '', cpf: '')

      user.valid?

      expect(user.errors.include?(:email)).to be true
      expect(user.errors.include?(:cpf)).to be true
    end

    it 'E-mail deve ser valido' do
      user = User.new(email: 'davidhotmailcom', cpf: '')

      user.valid?

      expect(user.errors.include?(:email)).to be true
    end

    it 'CPF deve ser valido' do
      user = User.new(email: '', cpf: '11122233344')

      user.valid?

      expect(user.errors.include?(:cpf)).to be true
    end

    
  end
end
