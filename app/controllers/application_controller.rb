class ApplicationController < ActionController::Base
  #Comes with application controller to ensure this application is safe
  #from hackers
  protect_from_forgery with: :exception

  #In order for views to use these two methods
  helper_method :current_user, :logged_in?

  #Creating a new session token for new user with User method created
  #in User model
  def login(user)
    session[:session_token] = user.reset_session_token
  end

  #Destroy session token for logged out user by way of User method created
  #in user model
  def logout
    current_user.reset_session_token
    session[:session_token] = nil
  end

  #Return a boolean value to know if a user is logged in so I grab the
  #current_user method's instance variable and return true or false
  #depending if there is in fact a current user by way of double bang,
  #which returns a true boolean value
  def logged_in?
    !!current_user
  end

  #Return an instance variable of the current user or create a new
  #instance variable if there is a new user by way of checking the
  #session_token
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  #If there is no user, redirect to Sign in page
  def require_login
    redirect_to new_api_v1_session_url unless logged_in?
  end

  #Using the params passed from the views and transaction controller,
  #I find the users involved in the transaction and update their credits
  #accordingly. They are then saved to to ensure their credits are in the
  #database. When a user sends credits, they were logged out after,
  #in line 55 they are logged back in
  def transfer_logic(receiver_id, amount)
    receiver = User.find(receiver_id)
    sender = current_user
    sender.credits -= amount
    receiver.credits += amount
    sender.save
    receiver.save
    login(sender)
  end
end
