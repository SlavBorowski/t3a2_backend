require 'rails_helper'

RSpec.describe "PrivateLandmarks", type: :request do
  describe "GET private_landmarks#show" do

    context "No private landmark has been created to show" do
      before(:example) do
        get "/private_landmark/test_landmark_title", headers: authenticated_header
        @json_response = JSON.parse(response.body)
      end

      it "returns no_landmark message in JSON response" do
        expect(@json_response['message']).to eq("no_landmark")
      end
    end

    context "Private landmark has been created to show" do
      before(:example) do
        FactoryBot.create(:private_landmark)
        user_id = PrivateLandmark.last.user_id
        get "/private_landmark/test_landmark_title", headers: authenticate_user_by_id(user_id)
        @json_response = JSON.parse(response.body)
      end

      it "returns landmark message in JSON response" do
        expect(@json_response['landmark']['message']).to eq("landmark")
      end
    end
  end


  describe "POST private_landmarks#create" do
    context "Private landmark has been created with valid attributes" do
      before(:example) do
        @landmark_params = {title: "test_landmark_title2", city: "city", image_number: 0}
        post private_landmark_path, params: @landmark_params, headers: authenticated_header
      end

      it "returns http created" do
        expect(response).to have_http_status(:created)
      end

      it 'saves the User to the database' do
        expect(PrivateLandmark.last.title).to eq(@landmark_params[:title])
      end
    end

    context 'when the Private landmark has invalid attributes' do
      before(:example) do
        @landmark_params = {title: nil, city: nil, image_number: 0}
        post private_landmark_path, params: @landmark_params, headers: authenticated_header
      end
  
      it 'returns http bad request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  # describe "DELETE private_landmarks#destroy" do
  #   it 'removes the Private Landmark from the database' do
  #     @landmark_params = {title: "test_landmark_title3", city: "city", image_number: 0}
  #     post private_landmark_path, params: @landmark_params, headers: authenticated_header
  #     landmark_user_id = PrivateLandmark.last.user_id
  #     p PrivateLandmark.all
  #     delete `/private_landmarks/test_landmark_title3`, headers: authenticate_user_by_id(landmark_user_id)
  #     expect(User.last.title).to_not eq(private_landmark[:title])
  #   end
  # end
end

