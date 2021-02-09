require 'rails_helper'

RSpec.describe "ItineraryItems", type: :request do
  describe "POST itinerary_items#create" do
    context "ItineraryItems has been created" do
      before(:example) do
        trip = FactoryBot.create(:trip)
        @itinerary_item_params = FactoryBot.attributes_for(:itinerary_item)
        post "/#{trip["title"]}/itinerary", params: { itinerary_item: @itinerary_item_params }, headers: authenticated_header
      end

      it "returns http created" do
        expect(response).to have_http_status(:created)
      end

      it 'saves the User to the database' do
        expect(ItineraryItem.last.name).to eq(@itinerary_item_params[:name])
      end
    end
  end

  describe "GET itinerary_items#index & itinerary_items#index_trip" do
    context "ItineraryItems has been created twice for render" do
      before(:example) do
        @trip = FactoryBot.create(:trip)
        @itinerary_item_params = FactoryBot.attributes_for(:itinerary_item)
        post "/#{@trip["title"]}/itinerary", params: { itinerary_item: @itinerary_item_params }, headers: authenticated_header
        post "/#{@trip["title"]}/itinerary", params: { itinerary_item: @itinerary_item_params }, headers: authenticated_header
        
        @trip2 = FactoryBot.create(:trip)
        post "/#{@trip2["title"]}/itinerary", params: { itinerary_item: @itinerary_item_params }, headers: authenticated_header
      end

      it "gets all itinerary items from the index" do
        get itinerary_path, headers: authenticate_user_by_id(@trip.user_id)
        @json_response = JSON.parse(response.body)
        expect(@json_response.length).to eq(2)
      end

      it "gets all itinerary items from the index_trip" do
        get "/#{@trip2.id}/itinerary", headers: authenticate_user_by_id(@trip2.user_id)
        @json_response = JSON.parse(response.body)
        expect(@json_response.length).to eq(1)
      end
    end

    
  end
end
