require 'rails_helper'

RSpec.describe 'DogWalking End Without Errors Api', type: :request do

  describe 'GET /dog_walking/:id/finish_walk' do
    context "When start walk with a valid uuid" do
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
        patch "/dog_walkings/#{@walk.id}/finish_walk", params: {}
      end
      it 'returns status :OK 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'changes walk status to finished' do
        @walk.reload
        expect(@walk.status).to eql('finished')
      end

      it 'changes walk end_date' do
        @walk.reload
        expect(@walk.end_date.nil?).to be_falsey
      end
    end

    context "When Finish with a invalid uuid" do
      before do
        Product.create({
          name: 'Caminhada de 60 min',
          duration: 60,
          first_price: 25,
          aditional_price: 15
        })
        create_list(:dog_walking, 5, schedule_date: Time.now + 1.hours, duration: 60, pets: 1, start_date: Time.now + 1.hours, end_date: (Time.now + 2.hours) + 2.minutes )
        @walk = DogWalking.all.sample
        @walk.start!
        patch "/dog_walkings/nao_existe/finish_walk", params: {}
      end
      it 'returns status :not_found 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end