# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::DialogicTestsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/dialogic_tests').to route_to('dialogic_tests#index')
    end

    it 'routes to #show' do
      expect(get: '/dialogic_tests/1').to route_to('dialogic_tests#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/dialogic_tests').to route_to('dialogic_tests#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/dialogic_tests/1').to route_to('dialogic_tests#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/dialogic_tests/1').to route_to('dialogic_tests#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/dialogic_tests/1').to route_to('dialogic_tests#destroy', id: '1')
    end
  end
end
