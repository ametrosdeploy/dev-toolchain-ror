# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::CustomersController, type: :routing do
  ADMIN_CUSTOMER_PATH = '/api/admin/v1/customers/1'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/customers')
        .to route_to('api/admin/v1/customers#index')
    end

    it 'routes to #show' do
      expect(get: ADMIN_CUSTOMER_PATH)
        .to route_to('api/admin/v1/customers#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/customers')
        .to route_to('api/admin/v1/customers#create')
    end

    it 'routes to #update via PUT' do
      expect(put: ADMIN_CUSTOMER_PATH)
        .to route_to('api/admin/v1/customers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: ADMIN_CUSTOMER_PATH)
        .to route_to('api/admin/v1/customers#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: ADMIN_CUSTOMER_PATH)
        .to route_to('api/admin/v1/customers#destroy', id: '1')
    end
  end
end
