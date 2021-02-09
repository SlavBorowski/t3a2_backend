require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST user#create" do
    context "Users sign-up" do
      before(:example) do
        @user_params = FactoryBot.attributes_for(:user)
        post sign_up_path, params: { user: @user_params }
      end
  
      it "returns http created" do
        expect(response).to have_http_status(:created)
      end

      it 'saves the User to the database' do
        expect(User.last.email).to eq(@user_params[:email])
      end

      describe "DELETE user#destroy" do
        it 'removes the User from the database' do
          user = FactoryBot.create(:user)
          delete "/user", headers: authenticate_user(user)
          expect(User.last.email).to_not eq(user[:email])
        end
      end
    end

    context 'when the User has invalid attributes' do
      before(:example) do
        @user_params = FactoryBot.attributes_for(:user, :invalid)
        post sign_up_path, params: { user: @user_params }
        @json_response = JSON.parse(response.body)
      end
  
      it 'returns http unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
  
      it 'returns the correct number of errors' do
        expect(@json_response['errors'].count).to eq(1)
      end
  
      it 'errors contains the correct message' do
        expect(@json_response['errors'][0]).to eq("Email can't be blank")
      end
    end
  end
end

