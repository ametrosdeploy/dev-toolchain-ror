# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::GlobalVideosController, type: :routing do
  GLOBAL_VIDEOS_PATH = '/api/admin/v1/global_videos/1'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/global_videos').to route_to('api/admin/v1/global_videos#index')
    end

    it 'routes to #show' do
      expect(get: GLOBAL_VIDEOS_PATH).to route_to('api/admin/v1/global_videos#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/global_videos').to route_to('api/admin/v1/global_videos#create')
    end

    it 'routes to #update via PUT' do
      expect(put: GLOBAL_VIDEOS_PATH).to route_to('api/admin/v1/global_videos#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: GLOBAL_VIDEOS_PATH).to route_to('api/admin/v1/global_videos#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: GLOBAL_VIDEOS_PATH).to route_to('api/admin/v1/global_videos#destroy', id: '1')
    end
  end
end
