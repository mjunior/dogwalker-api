class V1::DogWalkingsController < ApplicationController
  def index
    opts, result = DogWalkingListQuery.new(params).call
    render json: V1::DogWalkingSerializer.new(result,opts).serialized_json
  end
end