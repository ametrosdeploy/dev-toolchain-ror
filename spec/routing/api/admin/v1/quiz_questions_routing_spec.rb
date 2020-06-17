# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::QuizQuestionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/quiz_questions').to route_to('quiz_questions#index')
    end

    it 'routes to #show' do
      expect(get: '/quiz_questions/1').to route_to('quiz_questions#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/quiz_questions').to route_to('quiz_questions#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/quiz_questions/1').to route_to('quiz_questions#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/quiz_questions/1').to route_to('quiz_questions#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/quiz_questions/1').to route_to('quiz_questions#destroy', id: '1')
    end
  end
end
