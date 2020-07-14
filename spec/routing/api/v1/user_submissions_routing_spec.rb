# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UserSubmissionsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/api/v1/user_submissions/1')
        .to route_to('api/v1/user_submissions#show', id: '1')
    end
    it 'routes to #create' do
      expect(post: '/api/v1/user_submissions')
        .to route_to('api/v1/user_submissions#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/user_submissions/1')
        .to route_to('api/v1/user_submissions#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/user_submissions/1')
        .to route_to('api/v1/user_submissions#update', id: '1')
    end
  end
end
