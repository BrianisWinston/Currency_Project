class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def login(user)
    session[:session_token] = user.reset_session_token
  end

  def logout
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_login
    redirect_to new_api_v1_session_url unless logged_in?
  end

  def transfer_logic(receiver_id, amount)
    receiver = User.find(receiver_id)
    sender = current_user
    sender.credits -= amount
    receiver.credits += amount
    sender.save
    login(sender)
    receiver.save
  end
end
