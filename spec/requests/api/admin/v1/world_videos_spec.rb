require 'rails_helper'

RSpec.describe "Api::Admin::V1::WorldVideos", type: :request do
  describe "GET /api/admin/v1/world_videos" do
    it "works! (now write some real specs)" do
      get api_admin_v1_world_videos_path
      expect(response).to have_http_status(200)
    end
  end
end
