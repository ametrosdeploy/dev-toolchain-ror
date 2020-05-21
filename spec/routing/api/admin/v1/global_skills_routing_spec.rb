# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::GlobalSkillsController, type: :routing do
  GLOBAL_SKILL_PATH = '/api/admin/v1/global_skills/1'

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/admin/v1/global_skills')
        .to route_to('api/admin/v1/global_skills#index')
    end

    it 'routes to #show' do
      expect(get: GLOBAL_SKILL_PATH)
        .to route_to('api/admin/v1/global_skills#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/admin/v1/global_skills')
        .to route_to('api/admin/v1/global_skills#create')
    end

    it 'routes to #update via PUT' do
      expect(put: GLOBAL_SKILL_PATH)
        .to route_to('api/admin/v1/global_skills#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: GLOBAL_SKILL_PATH)
        .to route_to('api/admin/v1/global_skills#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: GLOBAL_SKILL_PATH)
        .to route_to('api/admin/v1/global_skills#destroy', id: '1')
    end
  end
end
