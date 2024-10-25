require 'rails_helper'

RSpec.describe RestaurantSchedule, type: :model do
  describe '#valid?' do
    it 'dados devem ser obrigatorios' do
      restaurant_schedule = RestaurantSchedule.new( mon_open: '', mon_close: '', tue_open: '', tue_close: '',
                            wed_open: '', wed_close: '', thu_open: '', thu_close: '',
                            fri_open: '', fri_close: '', sat_open: '', sat_close: '',
                            sun_open: '', sun_close: '')

      restaurant_schedule.valid?

      expect(restaurant_schedule.errors.include?(:mon_open)).to be true
      expect(restaurant_schedule.errors.include?(:mon_close)).to be true
      expect(restaurant_schedule.errors.include?(:tue_open)).to be true
      expect(restaurant_schedule.errors.include?(:tue_close)).to be true
      expect(restaurant_schedule.errors.include?(:wed_open)).to be true
      expect(restaurant_schedule.errors.include?(:wed_close)).to be true
      expect(restaurant_schedule.errors.include?(:thu_open)).to be true
      expect(restaurant_schedule.errors.include?(:thu_close)).to be true
      expect(restaurant_schedule.errors.include?(:fri_open)).to be true
      expect(restaurant_schedule.errors.include?(:fri_close)).to be true
      expect(restaurant_schedule.errors.include?(:sat_open)).to be true
      expect(restaurant_schedule.errors.include?(:sat_close)).to be true
      expect(restaurant_schedule.errors.include?(:sun_open)).to be true
      expect(restaurant_schedule.errors.include?(:sun_close)).to be true      
    end

    it 'Abertura não pode ser maior que fechamento' do
      restaurant_schedule = RestaurantSchedule.new( mon_open: '19:00', mon_close: '18:00', tue_open: '19:00', tue_close: '18:00',
      wed_open: '19:00', wed_close: '18:00', thu_open: '19:00', thu_close: '18:00',
      fri_open: '19:00', fri_close: '18:00', sat_open: '19:00', sat_close: '18:00',
      sun_open: '19:00', sun_close: '18:00')
      
      restaurant_schedule.valid?

      expect(restaurant_schedule.errors.include?(:mon_open)).to be true

      expect(restaurant_schedule.errors.include?(:tue_open)).to be true

      expect(restaurant_schedule.errors.include?(:wed_open)).to be true

      expect(restaurant_schedule.errors.include?(:thu_open)).to be true

      expect(restaurant_schedule.errors.include?(:fri_open)).to be true

      expect(restaurant_schedule.errors.include?(:sat_open)).to be true

      expect(restaurant_schedule.errors.include?(:sun_open)).to be true

    end


    it 'Usuário cadastra segundo horario' do
      admin = Admin.create!(name: 'David', last_name: 'Martinez', cpf: '12223111190', 
                  email: 'david@email.com', password: '123456789123')
      restaurant = Restaurant.create!(corporate_name: "McDonald's Curitiba", brand_name: "McDonald's", cnpj: 26219781000101, 
                    full_address: 'Av. Presidente Affonso Camargo, 10 - Rebouças, Curitiba - PR, 80060-090', 
                    email: 'contato@mcdonaldcr.com' ,telephone_number: 11999695714, admin: admin)    
      RestaurantSchedule.create!( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '08:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '18:00', restaurant: restaurant )

      second_restaurant_schedule = RestaurantSchedule.new( mon_open: '08:00', mon_close: '18:00', tue_open: '08:00', tue_close: '18:00',
                    wed_open: '08:00', wed_close: '18:00', thu_open: '07:00', thu_close: '18:00',
                    fri_open: '08:00', fri_close: '18:00', sat_open: '08:00', sat_close: '18:00',
                    sun_open: '08:00', sun_close: '10:00', restaurant: restaurant )
      
      expect(second_restaurant_schedule.valid?).to be_falsey
    end
    
  end


end
