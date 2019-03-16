class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :authenticate_user #, :user_admin

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] # only make the db call if there is in fact a sesion at the moment
  end

  # def require_user_log_in
  #   redirect_to root_path unless logged_in?
  # end

  def authenticate_user
    if !logged_in?
      flash[:danger] = "You must be loggin in to view that page."
      redirect_to new_user_path
    else logged_in?
      flash[:info] = "You are already logged in. Welcome back!"
      redirect_to users_path(@user)
    end
  end


end
