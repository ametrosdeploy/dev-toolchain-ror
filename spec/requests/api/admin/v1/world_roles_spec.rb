require 'rails_helper'

RSpec.describe "Api::Admin::V1::WorldRoles", type: :request do
  describe "GET /api/admin/v1/world_roles" do
    it "works! (now write some real specs)" do
      get api_admin_v1_world_roles_path
      expect(response).to have_http_status(200)
    end
  end
end
