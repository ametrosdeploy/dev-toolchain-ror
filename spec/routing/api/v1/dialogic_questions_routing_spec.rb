# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DialogicQuestionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/dialogic_questions')
        .to route_to('api/v1/dialogic_questions#index')
    end
  end
end
