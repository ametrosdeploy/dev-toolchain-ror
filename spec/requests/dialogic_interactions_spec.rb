require 'rails_helper'

RSpec.describe "DialogicInteractions", type: :request do
  describe "GET /dialogic_interactions" do
    it "works! (now write some real specs)" do
      get dialogic_interactions_path
      expect(response).to have_http_status(200)
    end
  end
end
