require 'rails_helper'

RSpec.describe 'DogWalking Create Without Errors Api', type: :request do

  describe 'GET /dog_walking' do
    context "When valid attributes" do
      before do
        Product.create({
          name: 'Caminhada de 30 min',
          duration: 30,
          first_price: 25,
          aditional_price: 15
        })
        attrs = attributes_for(:dog_walking,schedule_date: Time.now + 1.hours, duration: 30, pets: 1 )
        post '/dog_walkings', params: {dog_walking: attrs}
      end

      it 'returns status :OK' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns a walk' do
        expect(json_body[:data][:id].nil?).to be_falsey
      end

      it 'returns walk with correct status' do
        expect(json_body[:data][:attributes][:status]).to eql('scheduled')
      end

      it 'returns walk with a price' do
        expect(json_body[:data][:attributes][:price].nil?).to be_falsey
      end
    end
  end
end