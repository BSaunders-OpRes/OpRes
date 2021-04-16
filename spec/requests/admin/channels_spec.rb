require 'rails_helper'

RSpec.describe "Admin::Channels", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/channels/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/admin/channels/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/channels/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/channels/show"
      expect(response).to have_http_status(:success)
    end
  end

end
