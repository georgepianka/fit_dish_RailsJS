# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100. times do
  User.create(
    username: Faker::Name.name,
    email: Faker::Internet.free_email,
    password: "password",
    password_confirmation: "password"
  )
end


recipes = Recipe.create([
    {name: "Waffles", description: "Just Like Mom Used to Make It!", instructions: "Put the waffles in the toaster and heat them until toasted. Add syrup to your liking. Or, scrap all of that and just eat them frozen from the box.", user_id: 1},
])

100.times do
  Ingredient.create(
    name: Faker::Food.ingredient
  )
end
