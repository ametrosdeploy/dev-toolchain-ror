# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::AsstEntitiesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/asst_entities').to route_to('asst_entities#index')
    end

    it 'routes to #show' do
      expect(get: '/asst_entities/1').to route_to('asst_entities#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/asst_entities').to route_to('asst_entities#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/asst_entities/1').to route_to('asst_entities#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/asst_entities/1').to route_to('asst_entities#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/asst_entities/1').to route_to('asst_entities#destroy', id: '1')
    end
  end
end
