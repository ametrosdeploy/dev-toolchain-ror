# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::LearningObjectsController, type: :routing do
  LEARNING_OBJECT_PATH = '/learning_objects/1'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/learning_objects').to route_to('learning_objects#index')
    end

    it 'routes to #show' do
      expect(get: LEARNING_OBJECT_PATH)
        .to route_to('learning_objects#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/learning_objects').to route_to('learning_objects#create')
    end

    it 'routes to #update via PUT' do
      expect(put: LEARNING_OBJECT_PATH)
        .to route_to('learning_objects#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: LEARNING_OBJECT_PATH)
        .to route_to('learning_objects#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: LEARNING_OBJECT_PATH)
        .to route_to('learning_objects#destroy', id: '1')
    end
  end
end
