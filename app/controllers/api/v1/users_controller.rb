class Api::V1::UsersController < ApplicationController
  #Create instance variable of all users for views to manipulate
  def index
    @users = User.all
  end

  #For frontend to fill in new User attributes
  def new
    @user = User.new
  end

  def create
    #Create new user and pass whitelisted attributes from front end,
    #also provide new user with 100 credits
    @user = User.new(user_params)
    @user.credits = 100.00

    #If statement to login new user or display errors if user cannot be
    #saved
    if @user.save
      login(@user)
      redirect_to api_v1_users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  #Transaction method to display JSON object
  def current
    @current = User.find(current_user.id)
  end

  private

  #Keep code organized and hide params logic for best controller practice
  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
