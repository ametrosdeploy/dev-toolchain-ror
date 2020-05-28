# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::WorldRolesController, type: :routing do
  ADMIN_WORLD_ROLE_PATH = '/api/admin/v1/world_roles/1'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/world_roles')
        .to route_to('api/admin/v1/world_roles#index')
    end

    it 'routes to #show' do
      expect(get: ADMIN_WORLD_ROLE_PATH)
        .to route_to('api/admin/v1/world_roles#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/world_roles')
        .to route_to('api/admin/v1/world_roles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: ADMIN_WORLD_ROLE_PATH)
        .to route_to('api/admin/v1/world_roles#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: ADMIN_WORLD_ROLE_PATH)
        .to route_to('api/admin/v1/world_roles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: ADMIN_WORLD_ROLE_PATH)
        .to route_to('api/admin/v1/world_roles#destroy', id: '1')
    end
  end
end
