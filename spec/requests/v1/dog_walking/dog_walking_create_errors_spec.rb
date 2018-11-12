require 'rails_helper'

RSpec.describe 'DogWalking Create With Errors Api', type: :request do

  describe 'POST /dog_walking' do
    context "When invalid attributes" do
      before do
        Product.create({
          name: 'Caminhada de 30 min',
          duration: 30,
          first_price: 25,
          aditional_price: 15
        })
      end

      it 'returns message errors messages' do
        attrs = attributes_for(:dog_walking,schedule_date: Time.now + 1.hours, duration: 30, pets: 0 )
        post '/dog_walkings', params: {dog_walking: attrs}
        expect(json_body[:errors].nil?).to be_falsey  
      end

      it 'returns status unprocessable_entity' do
        attrs = attributes_for(:dog_walking,schedule_date: Time.now + 1.hours, duration: 30, pets: 0 )
        post '/dog_walkings', params: {dog_walking: attrs}
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns must be greater than 0' do
        attrs = attributes_for(:dog_walking,schedule_date: Time.now + 1.hours, duration: 30, pets: 0 )
        post '/dog_walkings', params: {dog_walking: attrs}
        expect(json_body[:errors][:pets]).to include("must be greater than 0")  
      end

      it "returns schedule_date can't be blank" do
        attrs = attributes_for(:dog_walking,schedule_date: nil, duration: 30, pets: 0 )
        post '/dog_walkings', params: {dog_walking: attrs}
        expect(json_body[:errors][:schedule_date]).to include("can't be blank")  
      end

      it "returns duration is not valid" do
        attrs = attributes_for(:dog_walking,schedule_date: nil, duration: 32, pets: 0 )
        post '/dog_walkings', params: {dog_walking: attrs}
        expect(json_body[:errors][:duration]).to include("32.0 is not a valid duration")  
      end
    end
  end
end