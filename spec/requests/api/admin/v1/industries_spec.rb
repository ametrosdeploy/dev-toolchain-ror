require 'rails_helper'

RSpec.describe "Api::Admin::V1::Industries", type: :request do
  describe "GET /api/admin/v1/industries" do
    it "works! (now write some real specs)" do
      get api_admin_v1_industries_path
      expect(response).to have_http_status(200)
    end
  end
end
