Rails.application.routes.draw do
  post "/login", to: "user_token#create"
  post "/sign-up", to: "users#create"
  post "/profile", to: "profiles#create"
  post "/:trip_title/itinerary", to: "itinerary_items#create"

  get "/profile", to: "profiles#show"
  get "/status", to: "status#index"
  get "/:trip_id/itinerary", to: "itinerary_items#index"

  delete "/user", to: "users#destroy"
  delete "/profile", to: "profiles#destroy"

  resources :trips, only: [:create, :index]
end
