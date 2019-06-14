class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :instructions, :like_count, :current_user_id
  has_many :recipe_ingredients, serializer: RecipeIngredientSerializer
  def like_count
    object.likes.count
  end

  def current_user_id
    current_user.id
  end

end
