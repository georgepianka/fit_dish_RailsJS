class Dish < ApplicationRecord
  belongs_to :user
  belongs_to :recipe


  def list_ingredients
      self.recipe.recipe_ingredients.map{|ing| ing.ingredient.name}
  end

end
