require 'rails_helper'

RSpec.describe "Admin::Institutions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/institutions/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/admin/institutions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/institutions/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/institutions/show"
      expect(response).to have_http_status(:success)
    end
  end

end
