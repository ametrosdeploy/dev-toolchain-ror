# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::LearnerDashboardsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/learner_dashboards')
        .to route_to('api/v1/learner_dashboards#index')
    end
  end
end
