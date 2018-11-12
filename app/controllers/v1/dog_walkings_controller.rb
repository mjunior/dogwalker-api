class V1::DogWalkingsController < ApplicationController
  before_action :set_walk, only: [:show,:start_walk, :finish_walk]
  def index
    opts, result = DogWalkingListQuery.new(params).call
    render json: V1::DogWalkingSerializer.new(result,opts).serialized_json, status: :ok
  end

  def show
    render json: V1::DogWalkingSerializer.new(@walk).serialized_json, status: :ok
  end

  def start_walk
    return head :not_found if @walk.nil?
    @walk.start!
    return head :ok if @walk.valid? 
    render json: { errors: @walk.errors }
  end

  def finish_walk
    return head :not_found if @walk.nil?
    @walk.finish!
    return head :ok if @walk.valid? 
    render json: { errors: @walk.errors }
  end

  private 
  def set_walk
    @walk = DogWalking.find_by(id: params[:id])
  end
end