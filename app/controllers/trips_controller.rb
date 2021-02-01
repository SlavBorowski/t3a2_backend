class TripsController < ApplicationController

  def create
    trip = Trips.new(trip_params)
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

