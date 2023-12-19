class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sign_out
    session[:user_data] = nil
    redirect_to root_url
  end

  def current_user
    return nil if session[:user_data].blank?
    @current_user ||= User.from_omniauth({
      :provider => "github",
      :uid => session[:user_data]["nickname"]
    })
  end
end
