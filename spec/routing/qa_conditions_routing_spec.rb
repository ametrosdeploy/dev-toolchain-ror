# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QaConditionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/qa_conditions').to route_to('qa_conditions#index')
    end

    it 'routes to #show' do
      expect(get: '/qa_conditions/1').to route_to('qa_conditions#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/qa_conditions').to route_to('qa_conditions#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/qa_conditions/1').to route_to('qa_conditions#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/qa_conditions/1').to route_to('qa_conditions#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/qa_conditions/1').to route_to('qa_conditions#destroy', id: '1')
    end
  end
end
