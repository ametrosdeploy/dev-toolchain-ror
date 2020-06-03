# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::UserSectionsController, type: :routing do
  USER_SECTION_PATH = '/api/admin/v1/sections/1'
  USER_SECTIONS_PATH = '/api/admin/v1/sections'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: USER_SECTIONS_PATH)
        .to route_to('api/admin/v1/user_sections#index')
    end

    it 'routes to #show' do
      expect(get: USER_SECTION_PATH)
        .to route_to('api/admin/v1/user_sections#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: USER_SECTIONS_PATH)
        .to route_to('api/admin/v1/user_sections#create')
    end

    it 'routes to #update via PUT' do
      expect(put: USER_SECTION_PATH)
        .to route_to('api/admin/v1/user_sections#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: USER_SECTION_PATH)
        .to route_to('api/admin/v1/user_sections#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: USER_SECTION_PATH)
        .to route_to('api/admin/v1/user_sections#destroy', id: '1')
    end
  end
end
