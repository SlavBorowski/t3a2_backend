class TripsController < ApplicationController
  before_action :authenticate_user

  def show
    trip = Trip.find(params[:trip_id])
    render json: trip
  end

  def create
    trip = Trip.new(trip_params)
    trip.user_id = current_user.id
    if trip.save 
      render status: :created
    else
      render status: :bad_request
    end
  end

  def update 
    # updating one trip
    trip = Trip.find(params[:trip_id])
    if trip.update(trip_params)
      render status: :no_content
    else
      render status: :bad_request
    end
  end

  def destroy
    trip = Trip.find(params[:trip_id])
    trip.destroy
  end

  def index_pending
    trips = Trip.where(user_id: current_user.id)
    trips = trips.sort_by {|trip| trip.date}
    trips = trips.select {|trip| trip.date >= Date.today }

    render json: trips
  end
  
  def index_completed
    trips = Trip.where(user_id: current_user.id)
    trips = trips.sort_by {|trip| trip.date}
    trips = trips.select {|trip| trip.date < Date.today }

    render json: trips
  end

  private 

  def trip_params 
    params.require(:trip).permit(:title, :date, :favoriteAttraction, :reflections, :city)
  end 

end

