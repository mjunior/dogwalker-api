# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.create({
  name: 'Caminhada de 30 min',
  duration: 30,
  first_price: 25,
  aditional_price: 15
})

Product.create({
  name: 'Caminhada 60 min',
  duration: 60,
  first_price: 35,
  aditional_price: 20
})

30.times do
  schedule = Time.now + [2,3,4,5,6,7,8].sample.hours
  duration = [30,60].sample
  attr = {
    schedule_date: schedule,
    duration: duration,
    latitude: -23.5104866,
    longitude: -46.8823115,
    pets: [1,2,3].sample,
    start_date: schedule,
    end_date: schedule + duration.hours
  }
  DogWalking.create(attr)
end

#old
30.times do
  schedule = Time.now - [2,3,4,5,6,7,8].sample.hours
  duration = [30,60].sample
  attr = {
    schedule_date: schedule,
    duration: duration,
    latitude: -23.5104866,
    longitude: -46.8823115,
    pets: [1,2,3].sample,
    start_date: schedule,
    end_date: schedule + duration.hours
  }
  DogWalking.create(attr)
end