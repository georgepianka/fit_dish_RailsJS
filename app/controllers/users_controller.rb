class UsersController < ApplicationController


  def show
    @user = User.find_by(id: params[:id])
    flash.now[:danger] = "Error."
  end

  def new
    @user = User.new
  end

  def index
    redirect_to new_user_path
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash.now.notice = "Error. Please try again #{@user.errors.full_messages.to_sentence}."
      render :new
    end
  end



  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
