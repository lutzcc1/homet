# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts 'creating users...'
50.times {
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'tenoch'
    )
}

puts 'users created'

puts 'creating meals...'
150.times {
  Meal.create!(
    name: Faker::Food.dish,
    description: Faker::Food.description,
    price: [50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600].sample,
    address: Faker::Address.full_address,
    min_eaters: rand(1..2),
    max_eaters:rand(2..10),
    user_id: rand(1..50)
    )
}

puts 'meals created'

puts 'creating bookings & reviews...'
100.times {
  user = rand(1..50)
  meal = rand(1..150)
    Booking.create!(
      date: Faker::Date.forward(days: 30),
      eaters: rand(2..5),
      user_id: user,
      meal_id: meal
      )
  Review.create!(
    comment: Faker::Restaurant.review,
    rating: rand(0..5),
    user_id: user,
    meal_id: meal
    )
}
puts 'bookings & reviews created'
