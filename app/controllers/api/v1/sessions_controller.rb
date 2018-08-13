class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login(@user)
      redirect_to api_v1_users_url
    else
      flash.now[:errors] = "The username/password you entered doesn't belong to an account. Please check and try again."
      render :new
    end
  end

  def destroy
    @user = current_user
    if @user
      logout
      redirect_to new_api_v1_user_url
    else
      flash.now[:errors] = "Nobody signed in"
    end
  end
end
