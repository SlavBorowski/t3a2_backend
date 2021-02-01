Rails.application.routes.draw do
  post "/login", to: "user_token#create"
  post "/sign-up", to: "users#create"

  # get "/profile", to: "users#show"

  get "/status", to: "status#index"

  resources :trips, only: [:create]
end
