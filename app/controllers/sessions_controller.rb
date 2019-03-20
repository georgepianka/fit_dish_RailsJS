class SessionsController < ApplicationController

  def new
  end

  def create
    if auth_hash = request.env["omniauth.auth"]
      @user = User.find_or_create_from_facebook(auth_hash)
      session[:user_id] = @user.id
      flash[:primary] = "Facebook Login Successful!"
      redirect_to user_path(@user)
    else
      authenticate_user
    end
  end

  def authenticate_user
    @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:primary] = "You're Logged In!"
        redirect_to user_path(@user)
      else
        flash.now[:danger] = "Login Error: Try Again!"
        render :new
      end
  end

  def destroy
    session.delete :user_id
    flash[:success] = "You Are Currently Logged Out."
    redirect_to root_path
  end

end
