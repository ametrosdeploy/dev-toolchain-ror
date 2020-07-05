# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::NluTrainingInputsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/nlu_training_inputs').to route_to('nlu_training_inputs#index')
    end

    it 'routes to #show' do
      expect(get: '/nlu_training_inputs/1').to route_to('nlu_training_inputs#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/nlu_training_inputs').to route_to('nlu_training_inputs#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/nlu_training_inputs/1').to route_to('nlu_training_inputs#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/nlu_training_inputs/1').to route_to('nlu_training_inputs#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/nlu_training_inputs/1').to route_to('nlu_training_inputs#destroy', id: '1')
    end
  end
end
