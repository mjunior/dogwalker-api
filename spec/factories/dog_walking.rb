# This will guess the User class
FactoryBot.define do
  factory :dog_walking do 
    schedule_date { Time.now + [2,3,4,5,6,7,8].sample.hours }
    duration { [30,60].sample }
    latitude { -23.5104866 }
    longitude { -46.8823115 }
    pets { [1,2,3].sample }
  end
end