require 'rails_helper'

RSpec.describe "Organisation::AdministrationPortals", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/organisation/administration_portal/index"
      expect(response).to have_http_status(:success)
    end
  end

end
