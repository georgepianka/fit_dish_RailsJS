class SubstitutionsController < ApplicationController

  before_action :require_login

  def new
      @substitution = Substitution.new
      @substitution.build_ingredient
      @recipe = Recipe.find(params[:recipe_id])
      @recipe_ingredients = @recipe.recipe_ingredients
  end


  def create
    raise params.inspect
    @substitution = current_user.substitutions.build(substitutions_params)
    if @substitution.save
      @recipe = Recipe.find(params[:recipe_id])
      flash[:primary] = "Added Substitution!"
      redirect_to user_recipe_path(current_user, @recipe)
    else
      flash.now[:danger] = "Failed to Add Substitution!"
      @substitution.build_ingredient
      @recipe = Recipe.find(params[:recipe_id])
      @recipe_ingredients = @recipe.recipe_ingredients
      render :new
    end
  end


  def index

  end

  def show

  end


  def create

  end

  private
      def substitutions_params
          params.require(:substitution).permit(:recipe_ingredient_id, :description, :quantity, ingredient_attributes: [:name])
      end

end
