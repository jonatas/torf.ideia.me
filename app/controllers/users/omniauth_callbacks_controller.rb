require "rest-client"

class Users::OmniauthCallbacksController < ApplicationController
  def github
    session[:user_data] ||= get_github_user_data

    @user = User.from_omniauth({
      :provider => "github",
      :uid => session[:user_data]["login"]
    })

    redirect_to root_url
  end

  private

  def get_github_access_token
    result = RestClient.post("https://github.com/login/oauth/access_token",
      {
        :client_id => ENV["GITHUB_APP_ID"],
        :client_secret => ENV["GITHUB_APP_SECRET"],
        :code => params["code"],
      },
      :accept => :json
    )

    JSON.parse(result)["access_token"]
  end

  def get_github_user_data
    result = RestClient.get("https://api.github.com/user", {
      :params => { :access_token => get_github_access_token }
    })

    JSON.parse(result)
  end

end
