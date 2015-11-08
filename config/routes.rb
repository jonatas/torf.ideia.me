Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match "/users/auth/:action/callback" => "users/omniauth_callbacks#:action",
    :as => "user_omniauth_callback",
    :via => [:get, :post]

  match "/sign_out" => "application#sign_out",
    :as => "sign_out",
    :via => [:get]

  resources :challenges
  root '/', controller: 'challenges', action: 'index'
end
