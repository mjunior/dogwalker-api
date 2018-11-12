require 'rails_helper'

RSpec.describe 'DogWalking Start Errors Api', type: :request do

  describe 'GET /dog_walking/:id/start_walki' do
    context "When to start a walk that is in progress" do
      before do
        Product.create({
          name: 'Caminhada de 60 min',
          duration: 60,
          first_price: 25,
          aditional_price: 15
        })
        create_list(:dog_walking, 5, schedule_date: Time.now + 1.hours, duration: 60, pets: 1)
        @walk = DogWalking.all.sample
        @walk.start!
        patch "/dog_walkings/#{@walk.id}/start_walk", params: {}
      end
      it 'returns errors' do
        expect(json_body.has_key?(:errors)).to be_truthy
      end

      it 'returns status unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
      
      it 'returns message error' do
        expect(json_body[:errors][:status]).to include("invalid change status 'in_progress' to 'in_progress'")
      end
    end

    context "When to start a walk that is finished" do
      before do
        Product.create({
          name: 'Caminhada de 60 min',
          duration: 60,
          first_price: 25,
          aditional_price: 15
        })
        create_list(:dog_walking, 5, schedule_date: Time.now + 1.hours, duration: 60, pets: 1)
        @walk = DogWalking.all.sample
        @walk.start!
        @walk.finish!
        patch "/dog_walkings/#{@walk.id}/start_walk", params: {}
      end
      it 'returns errors' do
        expect(json_body.has_key?(:errors)).to be_truthy
      end

      it 'returns message error' do
        expect(json_body[:errors][:status]).to include("invalid change status 'finished' to 'in_progress'")
      end
    end
  end
end