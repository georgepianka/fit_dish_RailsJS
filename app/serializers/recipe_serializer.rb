class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :instructions, :like_count, :user_id
  has_many :recipe_ingredients, serializer: RecipeIngredientSerializer
  def like_count
    object.likes.count
  end

  def user_id
    object.user.id
  end

end
