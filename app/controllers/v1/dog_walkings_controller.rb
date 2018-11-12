class V1::DogWalkingsController < ApplicationController
  before_action :set_walk, only: [:show,:start_walking, :end_walking]
  def index
    opts, result = DogWalkingListQuery.new(params).call
    render json: V1::DogWalkingSerializer.new(result,opts).serialized_json, status: :ok
  end

  def show
    render json: V1::DogWalkingSerializer.new(@walk).serialized_json, status: :ok
  end

  private 
  def set_walk
    @walk = DogWalking.find_by(id: params[:id])
  end
end