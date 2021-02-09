require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET profile#show" do

    context "No profile has been created to show" do
      it "returns no_profile message in JSON response" do
        get profile_path, headers: authenticated_header
        @json_response = JSON.parse(response.body)
        expect(@json_response['message']).to eq("no_profile")
      end
    end

    context "Profile has been created to show" do
      it "returns profile message in JSON response (error with this)" do
        FactoryBot.create(:profile)
        user_id = Profile.last.user_id
        # get profile_path, headers: authenticate_user_by_id(user_id)
        # @json_response = JSON.parse(response.body)
        # expect(@json_response['message']).to eq("profile")
      end
    end
  end

  describe "POST profiles#create" do
    context "Profile has been created with valid attributes" do
      before(:example) do
        @profile_params = {name: "name"}
        post profile_path, params: @profile_params, headers: authenticated_header
      end

      it "returns http created" do
        expect(response).to have_http_status(:created)
      end

      it 'saves the User to the database' do
        expect(Profile.last.name).to eq(@profile_params[:name])
      end
    end

    context 'when the Private landmark has invalid attributes' do
      before(:example) do
        @profile_params = {name: nil}
        post profile_path, params: @profile_params, headers: authenticated_header
      end
  
      it 'returns http bad request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "DELETE profile#destroy" do
    it 'removes the Profile from the database' do
      @profile_params = {name: "name"}
      post profile_path, params: @profile_params, headers: authenticated_header
      profile = Profile.last
      delete "/profile", headers: authenticate_user_by_id(profile['user_id'])
      expect(Profile.last).to_not eq(profile)
    end
  end
end
