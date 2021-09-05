# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(0..10).step(0.25) do |step|
  Quantity.create(amount: step)
end

Instruction.create(short_hand_name: "Wash Hands", description: "Lets start with some clean hands", time_amount: 120)
Ingredient.create(name: "Love", description: "Ensures a good time")
measurements = %w[Cup Spoon Tablespoon Teaspoon Slice]
measurements.each do |measurement|
  Measurement.create(name: measurement)
end