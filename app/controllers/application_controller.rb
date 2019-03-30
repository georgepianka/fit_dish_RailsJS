class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] # only make the db call if there is in fact a sesion at the moment
  end

  private


      def require_login
        redirect_to root_path unless logged_in?
      end

      def find_user_by_id
        params[:user_id] ? @user = User.find(params[:user_id]) : @user = User.find(params[:id])
      end

      def find_recipe_by_id
        params[:recipe_id] ? @recipe = Recipe.find(params[:recipe_id]) : @recipe = Recipe.find(params[:id])
      end

      def authorized?
        if find_user_by_id != current_user
          flash[:danger] = "You can only view your own Profile/Dishes/Grocery List!"
          redirect_to user_path(current_user)
        end
      end

end
