require "rails_helper"

RSpec.describe PriceCalculator do
  let!(:product) do 
    Product.create({
      name: 'Caminhada de 30 min',
      duration: 30,
      first_price: 25,
      aditional_price: 15
    })
  end
  
  context "#calculate" do
    it 'returns correct price for one pet' do
      walk = create(:dog_walking, duration: 30, pets: 1, schedule_date: Time.now, latitude: 1, longitude: 2)
      expect(PriceCalculator.new(walk).calculate).to eql(((walk.pets - 1) * product.aditional_price) + product.first_price) 
    end

    it 'returns correct price for more than one pets' do
      walk = create(:dog_walking, duration: 30, pets: 5, schedule_date: Time.now, latitude: 1, longitude: 2)
      expect(PriceCalculator.new(walk).calculate).to eql(((walk.pets - 1) * product.aditional_price) + product.first_price) 
    end
  end
end