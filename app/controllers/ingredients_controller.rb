class IngredientsController < ApplicationController

  before_action :require_login


  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
      if @ingredient.save!
        flash[:primary] = "Ingredient Added!"
        redirect_to ingredients_path
      else
        flash.now[:danger] = "Failed to Add Ingredient!"
        render :new
      end
  end

  def index
    @ingredients = Ingredient.all
  end

  def destroy
    @ingredient.destroy
    redirect_to ingredients_path
  end

  private

    def ingredient_params
      params.require(:ingredient).permit(:name)
    end

end
