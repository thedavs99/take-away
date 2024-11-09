require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#valid?' do
    context 'presence' do 
      it 'false when name is empty' do
        # Arrange
        admin = Admin.new(name: '', last_name: 'Martinez', cpf: '12223111190', 
        email: 'david@email.com', password: '123456789123')

        # Assert 
        expect(admin.valid?).to be_falsey
      end

      it 'false when last_name is empty' do
        # Arrange
        admin = Admin.new(name: 'David', last_name: '', cpf: '12223111190', 
        email: 'david@email.com', password: '123456789123')

        # Assert 
        expect(admin.valid?).to be_falsey
      end

      it 'false when cpf is empty' do
        # Arrange
        admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '' , 
        email: 'david@email.com', password: '123456789123')

        # Assert 
        expect(admin.valid?).to be_falsey
      end

      it 'false when email is empty' do
        # Arrange
        admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
        email: '', password: '123456789123')

        # Assert 
        expect(admin.valid?).to be_falsey
      end
      
    end

    it 'false when email is not valid' do
      # Arrange
      admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@emailcom', password: '123456789123')

      # Assert 
      expect(admin.valid?).to be_falsey
    end

    it 'false when password.length < 12' do
      # Arrange
      admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                        email: 'david@email.com', password: '12345678912')
      
      # Assert 
      expect(admin.valid?).to be_falsey
    end

    it 'false when cpf invalid' do
      # Arrange
      admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '12345678901', 
                        email: 'david@email.com', password: '123456789123')
      
      # Assert 
      expect(admin.valid?).to be_falsey
    end

    it 'Admin is not an restaurant_owner' do
      # Arrange
      admin = Admin.new(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                        email: 'david@email.com', password: '123456789123')
      
      # Assert 
      expect(admin.restaurant_owner).to be_falsey
    end
    
    it 'Admin is an restaurant_owner' do
      # Arrange
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
      email: 'david@email.com', password: '123456789123')

        # Assert 
      expect(admin.admin_type).to eq 'owner'
    end
  end
end
