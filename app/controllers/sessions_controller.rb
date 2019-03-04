class SessionsController < ApplicationController

  def new
    raise params.inspect
  end

  def create
    if auth_hash = request.env["omniauth.auth"]
      @user = User.find_or_create_by_omniauth(auth_hash)
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
     @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        redirect_to login_path
        flash[:notice] = "Error: Please Login"
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

end
