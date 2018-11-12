require 'rails_helper'

RSpec.describe 'DogWalking index Api', type: :request do

  describe 'GET /dog_walking' do
    context "When to list only future walks" do
      before do
        Product.create({
          name: 'Caminhada de 30 min',
          duration: 30,
          first_price: 25,
          aditional_price: 15
        })
        create_list(:dog_walking, 5, schedule_date: Time.now + 1.hours, duration: 30, pets: 1 )
        create_list(:dog_walking, 5, schedule_date: Time.now - 2.days, duration: 30, pets: 1 )
        get '/dog_walkings', params: {}
      end

      it 'returns status :OK' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns a list of dog walkings' do
        expect(json_body[:data].count).to eq(5)
      end
    end

    context "When to list all walks" do
      before do
        Product.create({
          name: 'Caminhada de 30 min',
          duration: 30,
          first_price: 25,
          aditional_price: 15
        })
        create_list(:dog_walking, 5, schedule_date: Time.now + 1.hours, duration: 30, pets: 1 )
        create_list(:dog_walking, 5, schedule_date: Time.now - 2.days, duration: 30, pets: 1 )
        get '/dog_walkings?all=true', params: {}
      end

      it 'returns status :OK' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns a list of dog walkings' do
        expect(json_body[:data].count).to eq(10)
      end
    end
  end
end