# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::WysiwygImagesController, type: :routing do
  ADMIN_WYSIWYG_PATH = '/api/admin/v1/world_roles/1'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/wysiwyg_images')
        .to route_to('api/admin/v1/wysiwyg_images#index')
    end

    it 'routes to #show' do
      expect(get: ADMIN_WYSIWYG_PATH)
        .to route_to('api/admin/v1/wysiwyg_images#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/wysiwyg_images')
        .to route_to('api/admin/v1/wysiwyg_images#create')
    end

    it 'routes to #update via PUT' do
      expect(put: ADMIN_WYSIWYG_PATH)
        .to route_to('api/admin/v1/wysiwyg_images#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: ADMIN_WYSIWYG_PATH)
        .to route_to('api/admin/v1/wysiwyg_images#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: ADMIN_WYSIWYG_PATH)
        .to route_to('api/admin/v1/wysiwyg_images#destroy', id: '1')
    end
  end
end
