# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EntityEvaluationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/entity_evaluations').to route_to('entity_evaluations#index')
    end

    it 'routes to #show' do
      expect(get: '/entity_evaluations/1').to route_to('entity_evaluations#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/entity_evaluations').to route_to('entity_evaluations#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/entity_evaluations/1').to route_to('entity_evaluations#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/entity_evaluations/1').to route_to('entity_evaluations#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/entity_evaluations/1').to route_to('entity_evaluations#destroy', id: '1')
    end
  end
end
