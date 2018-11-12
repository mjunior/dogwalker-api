# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.find_or_create_by({
  name: 'Caminhada de 30 min',
  duration: 30,
  first_price: 25,
  aditional_price: 15
})

Product.find_or_create_by({
  name: 'Caminhada 60 min',
  duration: 60,
  first_price: 35,
  aditional_price: 20
})