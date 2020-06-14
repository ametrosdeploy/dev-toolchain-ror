# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuizResponsesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/quiz_responses').to route_to('quiz_responses#index')
    end

    it 'routes to #show' do
      expect(get: '/quiz_responses/1').to route_to('quiz_responses#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/quiz_responses').to route_to('quiz_responses#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/quiz_responses/1').to route_to('quiz_responses#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/quiz_responses/1').to route_to('quiz_responses#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/quiz_responses/1').to route_to('quiz_responses#destroy', id: '1')
    end
  end
end
