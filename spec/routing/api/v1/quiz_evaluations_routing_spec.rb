# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::QuizEvaluationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/quiz_evaluations').to route_to('quiz_evaluations#index')
    end

    it 'routes to #show' do
      expect(get: '/quiz_evaluations/1').to route_to('quiz_evaluations#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/quiz_evaluations').to route_to('quiz_evaluations#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/quiz_evaluations/1').to route_to('quiz_evaluations#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/quiz_evaluations/1').to route_to('quiz_evaluations#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/quiz_evaluations/1').to route_to('quiz_evaluations#destroy', id: '1')
    end
  end
end
