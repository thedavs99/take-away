require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "#valid?" do
    it 'campo não pode estar vacio' do
      dish = Dish.new(name: '', description: '', calories: '')

      dish.valid?

      expect(dish.errors.include?(:name)).to be true
      expect(dish.errors.include?(:description)).to be true
      expect(dish.errors.include?(:calories)).to be true   
    end
  end
end
