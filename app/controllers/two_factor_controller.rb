class TwoFactorController < ApplicationController
  layout false
  skip_before_action :require_login
  before_action :require_auth

  def new
  end

  def create
    if @user.authenticate_otp(params[:otp])
      if params[:trust_computer]
        cookies.permanent.signed[:trust_token] = @user.trust_token
      else
        cookies.signed[:trust_token] = @user.trust_token
      end
      redirect_to(session[:return_to] || root_path)
    else
      flash.now.alert = 'Invalid OTP'
      render 'new'
    end
  end

  def require_auth
    @user = User.find_by_auth_token(cookies.signed[:auth_token]) if cookies.signed[:auth_token]
    unless @user
      flash[:alert] = "You Must Be Logged in to Continue"
      redirect_to login_url
    end
  end
end
