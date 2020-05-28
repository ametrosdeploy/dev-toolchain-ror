# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::LearnerDashboards', type: :request do
  describe 'GET /api/v1/learner_dashboards' do
    it 'works! (now write some real specs)' do
      get api_v1_learner_dashboards_path
      expect(response).to have_http_status(200)
    end
  end
end
