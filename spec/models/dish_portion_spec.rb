require 'rails_helper'

RSpec.describe DishPortion, type: :model do
  describe "#valid?" do
    it 'campo não pode estar vacio' do
      dish_portion = DishPortion.new(description:'', price: '')

      dish_portion.valid?

      expect(dish_portion.errors.include?(:price)).to be true  
    end    
  end
end
