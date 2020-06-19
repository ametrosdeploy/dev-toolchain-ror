# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::GendersController, type: :routing do
  GLOBAL_GENDER_PATH = '/api/admin/v1/genders/1'
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/genders')
        .to route_to('api/admin/v1/genders#index')
    end

    it 'routes to #show' do
      expect(get: GLOBAL_GENDER_PATH)
        .to route_to('api/admin/v1/genders#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/genders')
        .to route_to('api/admin/v1/genders#create')
    end

    it 'routes to #update via PUT' do
      expect(put: GLOBAL_GENDER_PATH)
        .to route_to('api/admin/v1/genders#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: GLOBAL_GENDER_PATH)
        .to route_to('api/admin/v1/genders#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: GLOBAL_GENDER_PATH)
        .to route_to('api/admin/v1/genders#destroy', id: '1')
    end
  end
end
