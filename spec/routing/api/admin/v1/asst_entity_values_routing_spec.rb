# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::AsstEntityValuesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/asst_entity_values').to route_to('asst_entity_values#index')
    end

    it 'routes to #show' do
      expect(get: '/asst_entity_values/1').to route_to('asst_entity_values#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/asst_entity_values').to route_to('asst_entity_values#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/asst_entity_values/1').to route_to('asst_entity_values#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/asst_entity_values/1').to route_to('asst_entity_values#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/asst_entity_values/1').to route_to('asst_entity_values#destroy', id: '1')
    end
  end
end
