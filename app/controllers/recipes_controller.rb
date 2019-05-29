class RecipesController < ApplicationController
  before_action :require_login
  before_action :authorized?
  before_action :find_recipe_by_id, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @recipes = Recipe.all
    case params[:order]
      when "your_recipes"
        @recipes = Recipe.your_recipes(current_user.id).recent
      when "recent"
        @recipes = Recipe.recent
      when "alphabetical"
        @recipes = Recipe.alphabetical
      when "popular"
        @recipes = Recipe.popular.recent.all
     end
     if params[:ingredient_name]
      @recipes = Recipe.search_by_ingredient(params[:ingredient_name])
      @search_term = params[:ingredient_name]
     elsif params[:name]
      @recipes = Recipe.search_by_name(params[:name])
      @search_term = params[:name]
     end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:primary] = "Recipe Created!"
      redirect_to user_recipe_path(current_user, @recipe)
    else
      flash.now[:danger] = "Failed to Create Recipe!"
      render :new
    end
  end

  def edit

  end

  def update
    if @recipe.user_id == current_user.id
      if @recipe.update(recipe_params)
        flash[:primary] = "Recipe Info Updated!"
        redirect_to user_recipe_path(current_user, @recipe)
      else
        flash.now[:danger] = "Failed to Update Recipe!"
        4.times { @recipe.recipe_ingredients.build.build_ingredient }
        render :edit
      end
    else
      flash[:danger] = "You can only Edit Your Own Recipe!"
      redirect_to user_path(current_user)
    end
  end

  def destroy
    if @recipe.user_id == current_user.id
      @recipe.destroy!
      flash[:primary] = "Recipe Deleted!"
      redirect_to user_recipes_path(current_user)
    else
      flash[:danger] = "You can only Delete Your Own Recipe!"
      redirect_to user_path(current_user)
    end
  end

  private

      def recipe_params
        params.require(:recipe).permit(:name, :description, :instructions,
         recipe_ingredients_attributes: [:id, :quantity, :_destroy,
         ingredient_attributes: [:name]])
      end
end
