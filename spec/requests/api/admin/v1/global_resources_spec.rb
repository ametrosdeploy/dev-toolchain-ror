require 'rails_helper'

RSpec.describe "Api::Admin::V1::GlobalResources", type: :request do
  describe "GET /api/admin/v1/global_resources" do
    it "works! (now write some real specs)" do
      get api_admin_v1_global_resources_path
      expect(response).to have_http_status(200)
    end
  end
end
