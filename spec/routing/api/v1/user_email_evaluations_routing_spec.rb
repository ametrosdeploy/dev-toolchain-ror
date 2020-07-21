# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UserEmailEvaluationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/user_email_evaluations').to route_to('user_email_evaluations#index')
    end

    it 'routes to #show' do
      expect(get: '/user_email_evaluations/1').to route_to('user_email_evaluations#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/user_email_evaluations').to route_to('user_email_evaluations#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/user_email_evaluations/1').to route_to('user_email_evaluations#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/user_email_evaluations/1').to route_to('user_email_evaluations#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/user_email_evaluations/1').to route_to('user_email_evaluations#destroy', id: '1')
    end
  end
end
