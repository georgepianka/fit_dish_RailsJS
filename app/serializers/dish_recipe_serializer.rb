class DishRecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :instructions
  has_many :recipe_ingredients, serializer: RecipeIngredientSerializer
  has_many :substitutions, serializer: SubstitutionSerializer

end
