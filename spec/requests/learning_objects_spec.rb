require 'rails_helper'

RSpec.describe "LearningObjects", type: :request do
  describe "GET /learning_objects" do
    it "works! (now write some real specs)" do
      get learning_objects_path
      expect(response).to have_http_status(200)
    end
  end
end
