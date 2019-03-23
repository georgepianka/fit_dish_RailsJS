class DishesController < ApplicationController
  before_action :require_login
  before_action :authorized?

    def index
      @dishes = current_user.ingredient_lists.order( created_at: :desc)
    end

    def create
      @dish = current_user.dishes.build(dish_params)
      if @dish.save
        flash[:primary] = "Added Dish to Your Dishes!"
        redirect_to user_dishes_path(current_user)
      else
        @recipe = Recipe.find(params[:recipe_id])
        flash[:danger] = "Added Dish to Your Dishes!"
        redirect_to user_recipe_path(current_user, @recipe)
      end
    end

      def edit
        @dish = Dish.find(params[:id])
      end

      def update
        @dish = Dish.find(params[:id])
          @dish.update(note: params[:dish][:note])
        if @dish.save
          redirect_to user_dishs_path
        else
          render :edit
        end
      end

      def destroy
          @dish = Dish.find(params[:id])
          @dish.destroy
          redirect_to user_dishs_path
      end

      private

      def dish_params
          params.require(:dish).permit(:user_id, :recipe_id)
      end

end
