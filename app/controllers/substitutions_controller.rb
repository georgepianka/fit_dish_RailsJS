class SubstitutionsController < ApplicationController

  before_action :require_login

  def new
      @substitution = Substitution.new
      @substitution.build_ingredient
      find_recipe_by_id
      @recipe_ingredients = @recipe.recipe_ingredients
  end


  def create
    @substitution = current_user.substitutions.build(substitutions_params)
    if @substitution.save
      flash[:primary] = "Added Substitution!"
      redirect_to user_recipe_path(current_user, @substitution.recipe)
    else
      flash.now[:danger] = "Failed to Add Substitution!"
      @substitution.build_ingredient
      find_recipe_by_id
      @recipe_ingredients = @recipe.recipe_ingredients
      render :new
    end
  end

  def destroy
    @substitution = Substitution.find(params[:id])
    @substitution.destroy!
    flash[:primary] = "Substitution Deleted!"
    find_recipe_by_id
    redirect_to user_recipe_path(current_user, @recipe)
  end


  private
      def substitutions_params
          params.require(:substitution).permit(:recipe_id, :recipe_ingredient_id, :description, :quantity, ingredient_attributes: [:name])
      end

end
