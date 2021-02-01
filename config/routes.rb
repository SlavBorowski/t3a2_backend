Rails.application.routes.draw do
  post "/login", to: "user_token#create"
  post "/sign-up", to: "users#create"
  post "/profile", to: "profiles#create"

  get "/profile", to: "profiles#show"
  get "/status", to: "status#index"
end
