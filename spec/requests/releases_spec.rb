require 'rails_helper'

RSpec.describe "Releases", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/releases/show"
      expect(response).to have_http_status(:success)
    end
  end

end
