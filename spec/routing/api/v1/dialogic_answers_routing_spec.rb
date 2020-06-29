# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DialogicAnswersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/dialogic_answers').to route_to('dialogic_answers#index')
    end

    it 'routes to #show' do
      expect(get: '/dialogic_answers/1').to route_to('dialogic_answers#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/dialogic_answers').to route_to('dialogic_answers#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/dialogic_answers/1').to route_to('dialogic_answers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/dialogic_answers/1').to route_to('dialogic_answers#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/dialogic_answers/1').to route_to('dialogic_answers#destroy', id: '1')
    end
  end
end
