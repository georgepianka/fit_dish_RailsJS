class RecipesController < ApplicationController

  before_action :require_login

  def show
    set_recipe
  end

  def new
    @recipe = Recipe.new
    12.times { @recipe.recipe_ingredients.build.build_ingredient }
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:primary] = "Recipe Created!"
      redirect_to recipe_path(@recipe)
    else
      flash.now[:danger] = "Failed to Create Recipe!"
    # 12.times { @recipe.recipe_ingredients.build.build_ingredient }
      render :new
    end
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
