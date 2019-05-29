class SubstitutionsController < ApplicationController

  before_action :require_login


  def new
      @substitution = Substitution.new
      @substitution.build_ingredient
      find_recipe_by_id
      @recipe_ingredients = @recipe.recipe_ingredients
  end


  def create
    @substitution = current_user.substitutions.build(substitution_params)
    if @substitution.save
      flash[:primary] = "Added Substitution!"
      respond_to do |f|
				f.html {redirect_to user_recipe_path(current_user, @substitution.recipe)}
				f.json {render json: @substitution, status: 201}
      end
    else
      flash.now[:danger] = "Failed to Add Substitution!"
      respond_to do |f|
				f.html {render :new}
				f.json {render json: @substitution.errors.full_messages, status: 400}
      end
    end
  end
  render json: {response: 'invalid comment params'}, status: 400

  def destroy
    @substitution = Substitution.find(params[:id])
    @substitution.destroy!
    flash[:primary] = "Substitution Deleted!"
    find_recipe_by_id
    redirect_to user_recipe_path(current_user, @recipe)
  end


  private
      def substitution_params
          params.require(:substitution).permit(:recipe_id, :recipe_ingredient_id, :description, :quantity, ingredient_attributes: [:name])
      end

end
