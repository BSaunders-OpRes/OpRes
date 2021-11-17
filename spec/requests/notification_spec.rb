require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/notification/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/notification/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /viewed" do
    it "returns http success" do
      get "/notification/viewed"
      expect(response).to have_http_status(:success)
    end
  end

end
