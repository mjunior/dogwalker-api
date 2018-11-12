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
    return head :ok if @walk.start! 
    render json: errors(@walk), status: :unprocessable_entity
  end

  def finish_walk
    return head :not_found if @walk.nil?
    return head :ok if @walk.finish! 
    render json: errors(@walk), status: :unprocessable_entity
  end

  def create
    walk = DogWalking.new(walk_params)
    return render json: errors(walk), status: :unprocessable_entity unless walk.save
    render json: V1::DogWalkingSerializer.new(walk).serialized_json, status: :ok
  end

  private 
  def set_walk
    @walk = DogWalking.find_by(id: params[:id])
  end

  def walk_params
    params.require(:dog_walking).permit(:schedule_date, :duration, :latitude, :longitude, :pets)
  end
end