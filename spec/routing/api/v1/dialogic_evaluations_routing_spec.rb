# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DialogicEvaluationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/dialogic_evaluations').to route_to('dialogic_evaluations#index')
    end

    it 'routes to #show' do
      expect(get: '/dialogic_evaluations/1').to route_to('dialogic_evaluations#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/dialogic_evaluations').to route_to('dialogic_evaluations#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/dialogic_evaluations/1').to route_to('dialogic_evaluations#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/dialogic_evaluations/1').to route_to('dialogic_evaluations#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/dialogic_evaluations/1').to route_to('dialogic_evaluations#destroy', id: '1')
    end
  end
end
