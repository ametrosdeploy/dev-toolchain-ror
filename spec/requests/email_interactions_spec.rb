require 'rails_helper'

RSpec.describe "EmailInteractions", type: :request do
  describe "GET /email_interactions" do
    it "works! (now write some real specs)" do
      get email_interactions_path
      expect(response).to have_http_status(200)
    end
  end
end
