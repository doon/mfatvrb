class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  private
  def current_user
    @current_user ||= do_auth
  end

  def do_auth
    user = User.find_by_auth_token(cookies.signed[:auth_token]) if cookies.signed[:auth_token]
    if user && user.use2fa? && cookies.signed[:trust_token] != user.trust_token
      #this user wants to use second factor
        redirect_to new_two_factor_url
    end
    user
  end

  helper_method :current_user

 def require_login
    unless logged_in?
      flash[:alert] = "You Must Be Logged in to Continue"
      session[:return_to] =  request.url || root_path
      redirect_to login_url
    end
  end

  def logged_in?
    !!current_user
  end
end
