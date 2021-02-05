class ItineraryItemsController < ApplicationController
  before_action :authenticate_user

  def create
    itinerary_item = ItineraryItem.new(itinerary_item_params)
    itinerary_item.trip_id = Trip.where(title: params[:trip_title])[0].id
    if itinerary_item.save 
      render status: :created
    else
      render status: :bad_request
    end
  end
  
  def index
    items = ItineraryItem.where(trip_id: params[:trip_id])
    render json: items
  end  

  private 

  def itinerary_item_params 
    params.require(:itinerary_item).permit(:name, :POI_id, :time, :notes)
  end 
end
