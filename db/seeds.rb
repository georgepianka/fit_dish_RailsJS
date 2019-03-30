# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


george = User.create(
  username: "George",
  email: "george@email.com",
  password: "password1",
  password_confirmation: "password1"
)

paul = User.create(
  username: "Paul",
  email: "paul@email.com",
  password: "password2",
  password_confirmation: "password2"
)

mark = User.create(
  username: "Mark",
  email: "mark@email.com",
  password: "password3",
  password_confirmation: "password3"
)

george.recipes.create({"name"=>"Smores", "description"=>"Delicious Fireside Treat", "instructions"=>"Squish Chocolate and Marshmallow Between Graham Crackers and Stick in Fire.", "recipe_ingredients_attributes"=>{"0"=>{"ingredient_attributes"=>{"name"=>"Chocolate"}, "quantity"=>"1 Piece"}, "1"=>{"ingredient_attributes"=>{"name"=>"Marshmallow"}, "quantity"=>"2 Pieces"}, "2"=>{"ingredient_attributes"=>{"name"=>"Graham Cracker"}, "quantity"=>"2 Pieces"}}})

george.substitutions.create({"recipe_id"=>"1", "recipe_ingredient_id"=>"1", "description"=>"Why the heck not?", "quantity"=>"A heaping dollop", "ingredient_attributes"=>{"name"=>"Nutella"}})


50. times do
    george.recipes.create({
        "name"=>Faker::Food.dish, "description"=>Faker::Food.description, "instructions"=>Faker::Lorem.paragraph(16), "recipe_ingredients_attributes"=>{
            "0"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "1"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "2"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "3"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "4"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "5"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}
        }
    })
end

50. times do
    paul.recipes.create({
        "name"=>Faker::Food.dish, "description"=>Faker::Food.description, "instructions"=>Faker::Lorem.paragraph(16), "recipe_ingredients_attributes"=>{
            "0"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "1"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "2"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "3"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "4"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "5"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}
        }
    })
end

50. times do
    mark.recipes.create({
        "name"=>Faker::Food.dish, "description"=>Faker::Food.description, "instructions"=>Faker::Lorem.paragraph(16), "recipe_ingredients_attributes"=>{
            "0"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "1"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "2"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "3"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "4"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}, "5"=>{"ingredient_attributes"=>{"name"=>Faker::Food.ingredient}, "quantity"=>Faker::Food.measurement}
        }
    })
end

Recipe.first.likes.create([{user_id: 1}, {user_id: 2}, {user_id: 3}])
Recipe.find(2).likes.create([{user_id: 1}, {user_id: 2}])
Recipe.find(3).likes.create({user_id: 1})
Recipe.find(4).likes.create([{user_id: 1}, {user_id: 2}])

Recipe.last.likes.create({user_id: 1})


# Faker::Food.dish

# Faker::Food.description

# Faker::Lorem.paragraph(16)

# Faker::Food.ingredient

# Faker::Food.measurement
