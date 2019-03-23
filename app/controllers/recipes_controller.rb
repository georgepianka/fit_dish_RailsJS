class RecipesController < ApplicationController
  before_action :require_login
  before_action :authorized?
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

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
    12.times { @recipe.recipe_ingredients.build.build_ingredient }
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:primary] = "Recipe Created!"
      redirect_to user_recipe_path(current_user, @recipe)
    else
      flash.now[:danger] = "Failed to Create Recipe!"
    12.times { @recipe.recipe_ingredients.build.build_ingredient }
      render :new
    end
  end

  def edit
    4.times { @recipe.recipe_ingredients.build.build_ingredient }
  end

  def update
    if @recipe.update(recipe_params)
      flash[:primary] = "Recipe Info Updated!"
      redirect_to user_recipe_path(current_user, @recipe)
    else
      flash.now[:danger] = "Failed to Update Recipe!"
      4.times { @recipe.recipe_ingredients.build.build_ingredient }
      render :edit
    end
  end

  def destroy
    @recipe.destroy!
    flash[:primary] = "Recipe Deleted!"
    redirect_to user_recipes_path(current_user)
  end

  private

      def set_recipe
        @recipe = Recipe.find(params[:id])
      end

      def recipe_params
        params.require(:recipe).permit(:name, :description, :instructions,
         recipe_ingredients_attributes: [:id, :quantity, :_destroy,
         ingredient_attributes: [:name]])
      end
end
