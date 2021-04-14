require 'rails_helper'

RSpec.describe "Visitors", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/visitor/index"
      expect(response).to have_http_status(:success)
    end
  end

end
