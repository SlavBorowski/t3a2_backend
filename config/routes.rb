Rails.application.routes.draw do
  post "/login", to: "user_token#create"
  post "/sign-up", to: "users#create"
  post "/profile", to: "profiles#create"
  post "/trips", to: "trips#create"
  post "/:trip_title/itinerary", to: "itinerary_items#create"

  get "/profile", to: "profiles#show"
  get "/status", to: "status#index"
  get "/trips_pending", to: "trips#index_pending"
  get "/trips_completed", to: "trips#index_completed"
  get "/trips/:trip_title", to: "trips#show"
  get "/:trip_id/itinerary", to: "itinerary_items#index_trip"
  get "/itinerary", to: "itinerary_items#index"

  delete "/user", to: "users#destroy"
  delete "/profile", to: "profiles#destroy"

end
