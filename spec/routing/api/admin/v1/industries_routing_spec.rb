# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::IndustriesController, type: :routing do
  ADMIN_INDUSTRIES_PATH = '/api/admin/v1/industries/1'
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/industries').to route_to('api/admin/v1/industries#index')
    end

    it 'routes to #show' do
      expect(get: ADMIN_INDUSTRIES_PATH).to route_to('api/admin/v1/industries#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/industries').to route_to('api/admin/v1/industries#create')
    end

    it 'routes to #update via PUT' do
      expect(put: ADMIN_INDUSTRIES_PATH).to route_to('api/admin/v1/industries#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: ADMIN_INDUSTRIES_PATH).to route_to('api/admin/v1/industries#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: ADMIN_INDUSTRIES_PATH).to route_to('api/admin/v1/industries#destroy', id: '1')
    end
  end
end
