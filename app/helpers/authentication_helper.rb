module AuthenticationHelper
  def user_signed_in?
    session[:user_data].present?
  end

   AUTHORIZE_URL = "https://github.com/login/oauth/authorize?"

  def callback_url
    host =
      if Rails.env.production?
        "torf.ideia.me"
      else
        "localhost:3000"
      end
    "http://#{host}/users/auth/github/callback"
  end

  def github_sign_in_path
    _params = {
      client_id: ENV["GITHUB_APP_ID"],
      redirect_url: callback_url,
      state: SecureRandom.urlsafe_base64
    }

    AUTHORIZE_URL + _params.map { |i| i * "="  } * "&"
  end

  def current_user
    @current_user ||= User.from_omniauth({
      :provider => "github",
      :uid => session[:user_data]["nickname"]
    })
  end
end
