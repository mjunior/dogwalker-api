class V1::DogWalkingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :schedule_date, :status, :duration, :latitude, :longitude, :pets, :start_date, :end_date
  attribute :realtime_duration do |object|
    ((object.end_date - object.start_date ) / 60).to_i if object.finished?
  end
end
