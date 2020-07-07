require 'rails_helper'

RSpec.describe "EmailResponses", type: :request do
  describe "GET /email_responses" do
    it "works! (now write some real specs)" do
      get email_responses_path
      expect(response).to have_http_status(200)
    end
  end
end
