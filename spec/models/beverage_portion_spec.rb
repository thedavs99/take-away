require 'rails_helper'

RSpec.describe BeveragePortion, type: :model do
  describe "#valid?" do
    it 'campo não pode estar vacio' do
      beverage_portion = BeveragePortion.new(description:'', price: '')

      beverage_portion.valid?

      expect(beverage_portion.errors.include?(:price)).to be true  
    end    
  end
end
