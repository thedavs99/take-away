require 'rails_helper'

RSpec.describe Beverage, type: :model do
  describe "#valid?" do
    it 'campo não pode estar vacio' do
      beverage = Beverage.new(name: '', description: '', calories: '')

      beverage.valid?

      expect(beverage.errors.include?(:name)).to be true
      expect(beverage.errors.include?(:description)).to be true
      expect(beverage.errors.include?(:calories)).to be true   
    end
  end
end
