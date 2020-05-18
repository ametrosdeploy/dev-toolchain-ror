# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::LearnModsController, type: :routing do
  ADMIN_LEARN_MODS_PATH = '/api/admin/v1/learn_mods/1'
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/learn_mods').to route_to('api/admin/v1/learn_mods#index')
    end

    it 'routes to #show' do
      expect(get: ADMIN_LEARN_MODS_PATH).to route_to('api/admin/v1/learn_mods#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/learn_mods').to route_to('api/admin/v1/learn_mods#create')
    end

    it 'routes to #update via PUT' do
      expect(put: ADMIN_LEARN_MODS_PATH).to route_to('api/admin/v1/learn_mods#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: ADMIN_LEARN_MODS_PATH).to route_to('api/admin/v1/learn_mods#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: ADMIN_LEARN_MODS_PATH).to route_to('api/admin/v1/learn_mods#destroy', id: '1')
    end
  end
end
