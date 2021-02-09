class ItineraryItemsController < ApplicationController
  before_action :authenticate_user

  def create
    itinerary_item = ItineraryItem.new(itinerary_item_params)
    itinerary_item.trip_id = Trip.where(title: params[:trip_title])[0].id
    if itinerary_item.save 
      render status: :created
    end
  end
  
  def index
    trips = Trip.where(user_id: current_user.id)
    items = []
    trips.each do |trip|
      items.concat(ItineraryItem.where(trip_id: trip.id))
    end

    render json: items
  end  

  def index_trip
    itinerary_items = ItineraryItem.where(trip_id: params[:trip_id])
    render json: itinerary_items
  end  

  private 

  def itinerary_item_params 
    params.require(:itinerary_item).permit(:name, :POI_id, :time, :notes)
  end 
end
