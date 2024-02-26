# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
15.times do
  Kitten.create(
    name: Faker::Creature::Cat.name,
    age: rand(1..12),
    cutness: ["High", "Medium", "Low"].sample,
    softness: ["Fluffy", "Soft", "Smooth"].sample
  )
end
