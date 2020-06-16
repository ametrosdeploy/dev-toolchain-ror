# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DialogicQuestionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/dialogic_questions').to route_to('dialogic_questions#index')
    end

    it 'routes to #show' do
      expect(get: '/dialogic_questions/1').to route_to('dialogic_questions#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/dialogic_questions').to route_to('dialogic_questions#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/dialogic_questions/1').to route_to('dialogic_questions#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/dialogic_questions/1').to route_to('dialogic_questions#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/dialogic_questions/1').to route_to('dialogic_questions#destroy', id: '1')
    end
  end
end
