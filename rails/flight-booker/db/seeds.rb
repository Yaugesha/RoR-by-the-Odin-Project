# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
require 'faker'

airport_codes = [
  'JFK', 'LAX', 'ATL', 'ORD', 'LHR', 'CDG', 'HND', 'PEK', 'DXB', 'SIN', 'AMS', 'DFW', 'FRA', 'ICN', 'DEN', 'BKK', 'SFO', 'CAN', 'LAS', 'IST'
]

airport_codes.each do |code|
  Airport.create(code: code)
end

20.times do
  start_datetime = Faker::Time.between(from: DateTime.now, to: DateTime.now + 30)
  duration = "#{rand(10..20)} hours #{rand(0..59)} minutes"

  arrival_airport = Airport.all.sample
  departure_airport = Airport.all.sample

  while arrival_airport == departure_airport
    departure_airport = Airport.all.sample
  end

  Flight.create(
    start_datetime: start_datetime,
    duration: duration,
    arrival_airport: arrival_airport,
    departure_airport: departure_airport
  )
end
