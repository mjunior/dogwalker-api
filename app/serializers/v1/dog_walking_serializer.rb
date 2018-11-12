class V1::DogWalkingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :schedule_date, :duration, :latitude, :longitude, :total_pets, :start_date, :end_date

  
end
