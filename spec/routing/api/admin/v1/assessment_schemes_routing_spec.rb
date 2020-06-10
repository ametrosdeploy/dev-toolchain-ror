# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::AssessmentSchemesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/assessment_schemes').to route_to('/api/admin/v1/assessment_schemes#index')
    end

    it 'routes to #show' do
      expect(get: '/api/admin/v1/assessment_schemes/1').to route_to('/api/admin/v1/assessment_schemes#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/assessment_schemes').to route_to('/api/admin/v1/assessment_schemes#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/admin/v1/assessment_schemes/1').to route_to('/api/admin/v1/assessment_schemes#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/admin/v1/assessment_schemes/1').to route_to('/api/admin/v1/assessment_schemes#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/admin/v1/assessment_schemes/1').to route_to('/api/admin/v1/assessment_schemes#destroy', id: '1')
    end
  end
end
