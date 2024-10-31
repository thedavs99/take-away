require 'rails_helper'

RSpec.describe DishPreviousPrice, type: :model do
  describe "#valid?" do
    it 'campo não pode estar vacio' do
      dish_previous_price = DishPreviousPrice.new(price: '')

      dish_previous_price.valid?

      expect(dish_previous_price.errors.include?(:price)).to be true  
    end    
  end
end
