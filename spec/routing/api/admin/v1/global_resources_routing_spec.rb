# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::GlobalResourcesController, type: :routing do
  GLOBAL_RESOURCE_PATH = '/api/admin/v1/global_resources/1'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/global_resources').to route_to('api/admin/v1/global_resources#index')
    end

    it 'routes to #show' do
      expect(get: GLOBAL_RESOURCE_PATH).to route_to('api/admin/v1/global_resources#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/global_resources').to route_to('api/admin/v1/global_resources#create')
    end

    it 'routes to #update via PUT' do
      expect(put: GLOBAL_RESOURCE_PATH).to route_to('api/admin/v1/global_resources#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: GLOBAL_RESOURCE_PATH).to route_to('api/admin/v1/global_resources#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: GLOBAL_RESOURCE_PATH).to route_to('api/admin/v1/global_resources#destroy', id: '1')
    end
  end
end
