# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ModulesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/modules').to route_to('api/v1/modules#index')
    end
  end
end
