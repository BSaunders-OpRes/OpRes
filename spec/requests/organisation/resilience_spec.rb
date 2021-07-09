require 'rails_helper'

RSpec.describe "Organisation::Resiliences", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/organisation/resilience/index"
      expect(response).to have_http_status(:success)
    end
  end

end
