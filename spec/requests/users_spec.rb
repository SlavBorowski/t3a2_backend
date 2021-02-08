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
    end
  end
end

