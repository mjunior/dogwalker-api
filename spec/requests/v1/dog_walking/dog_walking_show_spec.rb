require 'rails_helper'

RSpec.describe 'DogWalking Show Api', type: :request do

  describe 'GET /dog_walking/:id' do
    context "When to list only future walks" do
      before do
        Product.create({
          name: 'Caminhada de 60 min',
          duration: 60,
          first_price: 25,
          aditional_price: 15
        })
        create_list(:dog_walking, 5, schedule_date: Time.now + 1.hours, duration: 60, pets: 1, start_date: Time.now + 1.hours, end_date: (Time.now + 2.hours) + 2.minutes )
        @walk = DogWalking.all.sample
        @walk.in_progress!
        @walk.finished!
        get "/dog_walkings/#{@walk.id}", params: {}
      end

      it 'returns status :OK' do
        expect(response).to have_http_status(:ok)
      end
      
      it 'returns a correct walk' do
        expect(json_body[:data][:id]).to eq(@walk.id)
      end

      it 'returns correct realtime duration' do
        expect(json_body[:data][:attributes][:realtime_duration]).to eq(62)
      end
    end
  end
end