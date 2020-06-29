# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::DialogicAssmntItemsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/dialogic_assmnt_items').to route_to('dialogic_assmnt_items#index')
    end

    it 'routes to #show' do
      expect(get: '/dialogic_assmnt_items/1').to route_to('dialogic_assmnt_items#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/dialogic_assmnt_items').to route_to('dialogic_assmnt_items#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/dialogic_assmnt_items/1').to route_to('dialogic_assmnt_items#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/dialogic_assmnt_items/1').to route_to('dialogic_assmnt_items#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/dialogic_assmnt_items/1').to route_to('dialogic_assmnt_items#destroy', id: '1')
    end
  end
end
