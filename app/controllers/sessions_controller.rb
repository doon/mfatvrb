class SessionsController < ApplicationController
  layout false

  skip_before_action :require_login, only: [:new,:create]

  def new
  end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent.signed[:auth_token] = user.auth_token
      else
        cookies.signed[:auth_token] = user.auth_token
      end
      redirect_to(session[:return_to] || root_path , notice: 'Logged in!')
    else
      flash.now.alert = 'Invalid Username or Password'
      render 'new'
    end
  end

  def destroy
    reset_session
    cookies.delete(:auth_token)
    redirect_to login_path, notice: 'Logged Out!'
  end
end
