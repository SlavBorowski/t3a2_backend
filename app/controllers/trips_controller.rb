class TripsController < ApplicationController
  before_action :authenticate_user

  def create
    trip = Trip.new(trip_params)
    trip.user_id = current_user.id
    if trip.save 
      render status: :created
    else
      render status: :bad_request
    end
  end

  private 

  def trip_params 
    params.require(:trip).permit(:title, :date, :favoriteAttraction, :reflections, :city)
  end 

end

