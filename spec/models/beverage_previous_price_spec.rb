require 'rails_helper'

RSpec.describe BeveragePreviousPrice, type: :model do
  describe "#valid?" do
    it 'campo não pode estar vacio' do
      beverage_previous_price = BeveragePreviousPrice.new(price: '')

      beverage_previous_price.valid?

      expect(beverage_previous_price.errors.include?(:price)).to be true  
    end    
  end
end
