class SubstitutionSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :description
  belongs_to :recipe_ingredient, serializer: RecipeIngredientSerializer
  belongs_to :ingredient, serializer: IngredientSerializer
end
