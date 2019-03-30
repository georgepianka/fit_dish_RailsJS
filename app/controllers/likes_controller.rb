class LikesController < ApplicationController

def like
    @user = current_user
    find_recipe_by_id
    @like = @user.like(@recipe)

end

def unlike
  @user = current_user
  @like = @user.likes.find_by_recipe_id(params[:recipe_id])
  find_recipe_by_id
  @like.destroy!

end

end
