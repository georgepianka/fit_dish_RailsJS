class DishesController < ApplicationController
  before_action :require_login
  before_action :authorized?

    def index
      @dishes = current_user.dishes.order( created_at: :desc)
    end

    def show
      @dish = Dish.find(params[:id])
      if @dish.user_id == current_user.id
        respond_to do |f|
          f.json {render json: @dish, include: ['recipe.recipe_ingredients.ingredient', 'recipe.substitutions.ingredient', 'recipe.substitutions.recipe_ingredient'], status: 200}
        end
      end
    end

    def create
      @dish = current_user.dishes.build(dish_params)
      if @dish.save
        flash[:primary] = "Added Dish to Your Dishes!"
        respond_to do |f|
  				f.html {redirect_to user_dishes_path(current_user)}
  				f.json {render json: @dish, include: ['recipe'], status: 201}
        end
      else
        find_recipe_by_id
        flash[:danger] = "Failed to Add Dish to Your Dishes!"
        respond_to do |f|
  				f.html {redirect_to user_recipe_path(current_user, @recipe)}
  				f.json {render json: {show_errors: render_to_string(partial: 'layouts/show_errors.html.erb', locals: {model: @dish})}, status: 422}
        end
      end
    end

    def destroy
      @dish = Dish.find(params[:id])
      if @dish.user_id == current_user.id
        @dish.destroy
        flash[:primary] = "Dish Removed!"
        respond_to do |f|
  				f.html {redirect_to user_dishes_path(current_user)}
  				f.json {render json: @dish, status: 200}
        end
      else
        flash[:danger] = "You can only Delete Your Own Dish!"
        respond_to do |f|
  				f.html {redirect_to user_path(current_user)}
  				f.json {render json: {}, status: 204}
        end

      end
    end

      private

      def dish_params
          params.require(:dish).permit(:user_id, :recipe_id)
      end

end
