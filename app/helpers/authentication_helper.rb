module AuthenticationHelper
  def user_signed_in?
    session[:user_data].present?
  end

  def github_sign_in_path
    if Rails.env.production?
      "https://github.com/login/oauth/authorize" +
      "?client_id=#{ENV["GITHUB_APP_ID"]}" +
      "&redirect_url=http://torf.r15.railsrumble.com/users/auth/github/callback" +
      "&state=#{SecureRandom.urlsafe_base64}"
    else
      "https://github.com/login/oauth/authorize" +
      "?client_id=#{ENV["GITHUB_APP_ID"]}" +
      "&redirect_url=http://localhost:3000/users/auth/github/callback" +
      "&state=#{SecureRandom.urlsafe_base64}"
    end
  end
end
