require 'rails_helper'

RSpec.describe "Trips", type: :request do
  describe "GET trips#show" do
    it "returns json: trip from show action" do
      trip = FactoryBot.create(:trip)
      get "/trips/#{trip.id}", headers: authenticated_header
      @json_response = JSON.parse(response.body)
      expect(@json_response['title']).to eq(trip.title)
    end
  end

  describe "POST trips#create" do
    context "Trip submission with valid credentials" do
      before(:example) do
        @trip_params = FactoryBot.attributes_for(:trip)
        post trips_path, params: { trip: @trip_params }, headers: authenticated_header
      end

      it "returns http created" do
        expect(response).to have_http_status(:created)
      end

      it 'saves the User to the database' do
        expect(Trip.last.title).to eq(@trip_params[:title])
      end
    end

    context 'when the Trip has invalid attributes' do
      before(:example) do
        @trip_params = FactoryBot.attributes_for(:trip, :invalid_trip)
        post trips_path, params: { trip: @trip_params }, headers: authenticated_header
      end
  
      it 'returns http bad request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "PUT trips#update" do
    context "when trip id can be found" do
      before(:example) do
        @trip = FactoryBot.create(:trip)
      end

      it 'returns http ok for valid update' do
        @trip_params = FactoryBot.attributes_for(:trip)
        put "/trips/#{@trip.id}", params: { trip: @trip_params }, headers: authenticated_header
        expect(response).to have_http_status(:ok)
      end

      it 'returns http bad_request for invalid update' do
        @trip_params = FactoryBot.attributes_for(:trip, :invalid_trip)
        put "/trips/#{@trip.id}", params: { trip: @trip_params }, headers: authenticated_header
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "DELETE trips#destroy" do
    it 'removes the Trip from the database' do
      trip = FactoryBot.create(:trip)
      delete "/trips/#{trip.id}", headers: authenticated_header
      expect(Trip.last).to_not eq(trip)
    end
  end

  describe "GET trips#index_pending & GET trips#index_completed" do
    context "One pending trip and one completed trip is created" do
      before(:example) do
        @trip_completed = FactoryBot.create(:trip)
      end

      it 'renders the trips completed' do
        get trips_completed_path, headers: authenticate_user_by_id(@trip_completed.user_id)
        @json_response = JSON.parse(response.body)
        expect(@json_response.length).to eq(1)
      end

      it 'renders the trips pending' do
        get trips_pending_path, headers: authenticate_user_by_id(@trip_completed.user_id)
        @json_response = JSON.parse(response.body)
        expect(@json_response).to eq([])
      end
    end
  end

end
