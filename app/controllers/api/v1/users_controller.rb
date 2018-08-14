class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.credits = 100.00

    if @user.save
      login(@user)
      redirect_to api_v1_users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def current
    @current = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
