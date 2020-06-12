# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::OverallAssmntItemsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/overall_assmnt_items').to route_to('overall_assmnt_items#index')
    end

    it 'routes to #show' do
      expect(get: '/overall_assmnt_items/1').to route_to('overall_assmnt_items#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/overall_assmnt_items').to route_to('overall_assmnt_items#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/overall_assmnt_items/1').to route_to('overall_assmnt_items#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/overall_assmnt_items/1').to route_to('overall_assmnt_items#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/overall_assmnt_items/1').to route_to('overall_assmnt_items#destroy', id: '1')
    end
  end
end
