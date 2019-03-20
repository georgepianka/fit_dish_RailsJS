class DishesController < ApplicationController
  before_action :require_login
  before_action :authorized?

  def index
    @dishes = current_user.recipe_lists
  end

      def create
        @dish = Dish.create(_params)
        if @dish.save
          redirect_to edit_user_dish_path(current_user, @dish)
        else
          render root_path
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
