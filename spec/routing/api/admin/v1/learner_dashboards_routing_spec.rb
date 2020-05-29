# frozen_string_literal: true

require 'rails_helper'

# Test cases for routes
RSpec.describe Api::Admin::V1::LearnerDashboardsController, type: :routing do
  ADMIN_LEARNER_PATH = '/api/admin/v1/learner_dashboards/1'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/learner_dashboards')
        .to route_to('api/admin/v1/learner_dashboards#index')
    end

    it 'routes to #show' do
      expect(get: ADMIN_LEARNER_PATH)
        .to route_to('api/admin/v1/learner_dashboards#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/learner_dashboards')
        .to route_to('api/admin/v1/learner_dashboards#create')
    end

    it 'routes to #update via PUT' do
      expect(put: ADMIN_LEARNER_PATH)
        .to route_to('api/admin/v1/learner_dashboards#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: ADMIN_LEARNER_PATH)
        .to route_to('api/admin/v1/learner_dashboards#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: ADMIN_LEARNER_PATH)
        .to route_to('api/admin/v1/learner_dashboards#destroy', id: '1')
    end
  end
end
