class LikesController < ApplicationController

def like
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @like = @user.like(@recipe)

end

def unlike
  @user = current_user
  @like = @user.likes.find_by_recipe_id(params[:recipe_id])
  @recipe = Recipe.find(params[:recipe_id])
  @like.destroy!

end

end
