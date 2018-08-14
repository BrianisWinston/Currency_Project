class Api::V1::SessionsController < ApplicationController
  def create
    #Use class method created in User model with params as arguments
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    #If statement to either login user or display errors and try again
    if @user
      login(@user)
      redirect_to api_v1_users_url
    else
      flash.now[:errors] = "The username/password you entered doesn't belong to an account. Please check and try again."
      render :new
    end
  end

  def destroy
    #If statement to logout user or throw errors
    @user = current_user
    if @user
      logout
      redirect_to new_api_v1_user_url
    else
      flash.now[:errors] = "Nobody signed in"
    end
  end
end
