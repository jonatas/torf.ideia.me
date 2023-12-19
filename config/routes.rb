Rails.application.routes.draw do
  resources :scores
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

  match "/sign_out" => "application#sign_out",
    :as => "sign_out",
    :via => [:get]

  resources :challenges
  root '/', controller: 'challenges', action: 'index'
end
