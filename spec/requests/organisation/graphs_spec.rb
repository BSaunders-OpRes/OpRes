require 'rails_helper'

RSpec.describe "Organisation::Graphs", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/organisation/graphs/show"
      expect(response).to have_http_status(:success)
    end
  end

end
