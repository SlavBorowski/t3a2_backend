Rails.application.routes.draw do
  post "/login", to: "user_token#create"
  get "/status", to: "status#index"

  post "/sign-up", to: "users#create"
  delete "/user", to: "users#destroy"

  get "/profile", to: "profiles#show"
  post "/profile", to: "profiles#create"
  delete "/profile", to: "profiles#destroy"

  get "/trips_pending", to: "trips#index_pending"
  get "/trips_completed", to: "trips#index_completed"
  get "/trips/:trip_id", to: "trips#show"
  post "/trips", to: "trips#create"
  put "/trips/:trip_id", to: "trips#update"
  delete "/trips/:trip_id", to: "trips#destroy"

  get "/:trip_id/itinerary", to: "itinerary_items#index_trip"
  get "/itinerary", to: "itinerary_items#index"
  post "/:trip_title/itinerary", to: "itinerary_items#create"

  get "/private_landmark/:landmark_title", to: "private_landmarks#show"
  post "/private_landmark", to: "private_landmarks#create"
  delete "/private_landmark/:landmark_title", to: "private_landmarks#destroy"

end
