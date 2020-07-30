# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::DialogicTestDebriefsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/dialogic_test_debriefs').to route_to('dialogic_test_debriefs#index')
    end

    it 'routes to #show' do
      expect(get: '/dialogic_test_debriefs/1').to route_to('dialogic_test_debriefs#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/dialogic_test_debriefs').to route_to('dialogic_test_debriefs#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/dialogic_test_debriefs/1').to route_to('dialogic_test_debriefs#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/dialogic_test_debriefs/1').to route_to('dialogic_test_debriefs#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/dialogic_test_debriefs/1').to route_to('dialogic_test_debriefs#destroy', id: '1')
    end
  end
end
