class UsersController < ApplicationController

  before_action :require_login, only: [:edit, :update, :show]
  before_action :authorized?, only: [:edit, :update, :show]

  def new
    @user = User.new
  end

  def show
    find_user_by_id
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash.now[:danger]= "Failed to Create User!"
      render :new
    end
  end

  def edit
      find_user_by_id
  end

  def update
    find_user_by_id
    @user.update(user_params)
    if @user.save
      flash[:primary] = "User Info Updated!"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Failed to Update User!"
      render :edit
    end
  end

  def index
  end

  private

      def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      end

end
