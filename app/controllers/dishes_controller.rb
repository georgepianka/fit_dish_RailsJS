class DishesController < ApplicationController
  before_action :require_login
  before_action :authorized?

    def index
      @dishes = current_user.dishes.order( created_at: :desc)
    end

    def create
      @dish = current_user.dishes.build(dish_params)
      if @dish.save
        flash[:primary] = "Added Dish to Your Dishes!"
        redirect_to user_dishes_path(current_user)
      else
        find_recipe_by_id
        flash[:danger] = "Failed to Add Dish to Your Dishes!"
        redirect_to user_recipe_path(current_user, @recipe)
      end
    end

    def destroy
      @dish = Dish.find(params[:id])
      if @dish.user_id == current_user.id
        @dish.destroy
        flash[:primary] = "Dish Removed!"
        redirect_to user_dishes_path(current_user)
      else
        flash[:danger] = "You can only Delete Your Own Dish!"
        redirect_to user_path(current_user)
      end
    end

      private

      def dish_params
          params.require(:dish).permit(:user_id, :recipe_id)
      end

end
