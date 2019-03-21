class RecipesController < ApplicationController
  before_action :require_login
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
=begin
    if params[:region] && params[:category]
      @world_wonders = WorldWonder.search(params[:region], params[:category])
   elsif params[:name]
     @world_wonders = WorldWonder.search_name(params[:name])
    else
      @world_wonders = WorldWonder.all.ordered
    end
=end
      @user_recipes = current_user.recipes
      @recipes = Recipe.all
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
  end

  def update
    @recipe.update(user_params)
    if @recipe.save
      flash[:primary] = "Recipe Info Updated!"
      redirect_to user_recipe_path(current_user, @recipe)
    else
      flash.now[:danger] = "Failed to Update Recipe!"
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:primary] = "Recipe Deleted!"
    redirect_to user_recipes_path(current_user)
  end

  private

      def set_recipe
        @recipe = Recipe.find(params[:id])
      end

      def recipe_params
        params.require(:recipe).permit(:name, :description, :instructions,
         recipe_ingredients_attributes: [:quantity,
         ingredient_attributes: [:name]])
      end
end
