# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QaFormulasController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/qa_formulas').to route_to('qa_formulas#index')
    end

    it 'routes to #show' do
      expect(get: '/qa_formulas/1').to route_to('qa_formulas#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/qa_formulas').to route_to('qa_formulas#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/qa_formulas/1').to route_to('qa_formulas#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/qa_formulas/1').to route_to('qa_formulas#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/qa_formulas/1').to route_to('qa_formulas#destroy', id: '1')
    end
  end
end
