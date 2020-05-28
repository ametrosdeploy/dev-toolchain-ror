# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::UsersController, type: :routing do
  ADMIN_USERS_PATH = '/api/admin/v1/users/1'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/users')
        .to route_to('api/admin/v1/users#index')
    end

    it 'routes to #show' do
      expect(get: ADMIN_USERS_PATH)
        .to route_to('api/admin/v1/users#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/users')
        .to route_to('api/admin/v1/users#create')
    end

    it 'routes to #update via PUT' do
      expect(put: ADMIN_USERS_PATH)
        .to route_to('api/admin/v1/users#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: ADMIN_USERS_PATH)
        .to route_to('api/admin/v1/users#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: ADMIN_USERS_PATH)
        .to route_to('api/admin/v1/users#destroy', id: '1')
    end
  end
end
