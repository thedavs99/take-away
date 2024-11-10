require 'rails_helper'

RSpec.describe Worker, type: :model do
  describe "#valid?" do
    it 'campo não pode estar vacio' do
      worker = Worker.new(email: '', cpf: '')

      worker.valid?

      expect(worker.errors.include?(:email)).to be true
      expect(worker.errors.include?(:cpf)).to be true
    end

    it 'E-mail deve ser valido' do
      worker = Worker.new(email: 'davidhotmailcom', cpf: '')

      worker.valid?

      expect(worker.errors.include?(:email)).to be true
    end

    it 'CPF deve ser valido' do
      worker = Worker.new(email: '', cpf: '11122233344')

      worker.valid?

      expect(worker.errors.include?(:cpf)).to be true
    end

    
  end
end
