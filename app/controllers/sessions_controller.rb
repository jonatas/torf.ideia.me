class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    session[:user_data] ||= auth["info"]

    @user = User.from_omniauth({
      :provider => "github",
      :uid => session[:user_data]["nickname"]
    })
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    # Access token is available in auth['credentials']['token']
    redirect_to root_path, notice: 'Signed in!'
  end

  def failure
    redirect_to root_path, alert: 'Authentication failed.'
  end
end

