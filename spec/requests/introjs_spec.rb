require 'rails_helper'

RSpec.describe "Introjs", type: :request do
  describe "GET /update_user_visit_status" do
    it "returns http success" do
      get "/introjs/update_user_visit_status"
      expect(response).to have_http_status(:success)
    end
  end

end
