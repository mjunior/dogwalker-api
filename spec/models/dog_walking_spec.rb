require "rails_helper"

RSpec.describe DogWalking, type: :model do

  let!(:product) do 
    Product.create({
      name: 'Caminhada de 30 min',
      duration: 30,
      first_price: 25,
      aditional_price: 15
    })
  end

  context '.create' do
    it 'creates with a correct price for more than one pets' do
      walk = create(:dog_walking, duration: 30, pets: 5, schedule_date: Time.now, latitude: 1, longitude: 2)
      expect(walk.price).to eql(PriceCalculator.new(walk).calculate) 
    end

    it 'creates with a correct price for one pet' do
      walk = create(:dog_walking, duration: 30, pets: 1, schedule_date: Time.now, latitude: 1, longitude: 2)
      expect(walk.price).to eql(PriceCalculator.new(walk).calculate) 
    end

    it 'creates with a correct status' do
      walk = create(:dog_walking, duration: 30, pets: 1, schedule_date: Time.now, latitude: 1, longitude: 2)
      expect(walk.scheduled?).to be_truthy 
    end
  end
end