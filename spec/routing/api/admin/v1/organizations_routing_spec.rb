# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::OrganizationsController, type: :routing do
  ADMIN_ORGANIZATION_PATH = '/api/admin/v1/organizations/1'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/organizations')
        .to route_to('api/admin/v1/organizations#index')
    end

    it 'routes to #show' do
      expect(get: ADMIN_ORGANIZATION_PATH)
        .to route_to('api/admin/v1/organizations#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/organizations')
        .to route_to('api/admin/v1/organizations#create')
    end

    it 'routes to #update via PUT' do
      expect(put: ADMIN_ORGANIZATION_PATH)
        .to route_to('api/admin/v1/organizations#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: ADMIN_ORGANIZATION_PATH)
        .to route_to('api/admin/v1/organizations#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: ADMIN_ORGANIZATION_PATH)
        .to route_to('api/admin/v1/organizations#destroy', id: '1')
    end
  end
end
