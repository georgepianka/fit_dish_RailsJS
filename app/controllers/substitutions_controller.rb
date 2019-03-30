class SubstitutionsController < ApplicationController

  before_action :require_login

  def new
      @substitution = Substitution.new
      @substitution.build_ingredient
      @recipe = Recipe.find(params[:recipe_id])
      @recipe_ingredients = @recipe.recipe_ingredients

  end


  def create

  end

  def index

  end

  def show

  end


  def create

  end

  private
      def substitutions_params
          params.require(:substitution).permit(:user_id, :recipe_ingredient_id, :description, :quantity, ingredient_attributes: [:name])
      end

end
