class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :instructions, :like_count
  has_many :recipe_ingredients, serializer: RecipeIngredientSerializer
  def like_count
    object.likes.count
  end



end
