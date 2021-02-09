require 'rails_helper'

RSpec.describe "Status", type: :request do
  describe "GET status#index" do

    it "should return ok when user has been authenticated" do
      get status_path, headers: authenticated_header
      expect(response).to have_http_status(:ok)
    end
  end
end
