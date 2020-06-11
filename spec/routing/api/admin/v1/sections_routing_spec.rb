# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::SectionsController, type: :routing do
  ADMIN_SECTION_PATH = '/api/admin/v1/sections/1'
  ADMIN_SECTIONS_PATH = '/api/admin/v1/sections'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: ADMIN_SECTIONS_PATH)
        .to route_to('api/admin/v1/sections#index')
    end

    it 'routes to #show' do
      expect(get: ADMIN_SECTION_PATH)
        .to route_to('api/admin/v1/sections#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: ADMIN_SECTIONS_PATH)
        .to route_to('api/admin/v1/sections#create')
    end

    it 'routes to #update via PUT' do
      expect(put: ADMIN_SECTION_PATH)
        .to route_to('api/admin/v1/sections#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: ADMIN_SECTION_PATH)
        .to route_to('api/admin/v1/sections#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: ADMIN_SECTION_PATH)
        .to route_to('api/admin/v1/sections#destroy', id: '1')
    end
  end
end
