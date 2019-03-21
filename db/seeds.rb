# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

product_hash = {product_attr1: product_attr1_val, product_attr2: product_attr2_val, attachementes_attributes: [{attach_attr1: attach_attr1_val}, {attach_attr1: attach_attr1_val}] }
Product.create(product_hash)

  User.last.recipes.create({name: "Smore", description: "Really Delicious", instructions: "Squish Marshmallow and Chocolate Between Graham Crackers and Stick it in the Fire!", recipe_ingredients_attributes: [{quantity: "2 pieces", {i}}]  )
    username: Faker::Name.name,
    email: Faker::Internet.free_email,
    password: "password",
    password_confirmation: "password"
  )
end

=begin



george = User.create(
  username: George,
  email: george@email.com,
  password: "password1",
  password_confirmation: "password1"
)

paul = User.create(
  username: Paul,
  email: paul@email.com,
  password: "password2",
  password_confirmation: "password2"
)

mark = User.create(
  username: Mark,
  email: mark@email.com,
  password: "password3",
  password_confirmation: "password3"
)


product_hash = {product_attr1: product_attr1_val, product_attr2: product_attr2_val, attachementes_attributes: [{attach_attr1: attach_attr1_val}, {attach_attr1: attach_attr1_val}] }
Product.create(product_hash)

10. times do
  george.recipes.create(name: , description: , instructions: ,  )
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


=end
