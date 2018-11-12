require 'rails_helper'

RSpec.describe 'DogWalking Finish Walk Api', type: :request do

  describe 'GET /dog_walking/:id/finish_start' do
    context "When to finish a walk that is scheduled" do
      before do
        Product.create({
          name: 'Caminhada de 60 min',
          duration: 60,
          first_price: 25,
          aditional_price: 15
        })
        create_list(:dog_walking, 5, schedule_date: Time.now + 1.hours, duration: 60, pets: 1)
        @walk = DogWalking.all.sample
        patch "/dog_walkings/#{@walk.id}/finish_walk", params: {}
      end
      it 'returns errors' do
        expect(json_body.has_key?(:errors)).to be_truthy
      end

      it 'returns message error' do
        expect(json_body[:errors][:status]).to include("invalid change status 'scheduled' to 'finished'")
      end
    end

    context "When to finish a walk alredy finished" do
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
        patch "/dog_walkings/#{@walk.id}/finish_walk", params: {}
      end
      it 'returns errors' do
        expect(json_body.has_key?(:errors)).to be_truthy
      end

      it 'returns message error' do
        expect(json_body[:errors][:status]).to include("invalid change status 'finished' to 'finished'")
      end
    end
  end
end