# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Modules', type: :request do
  describe 'GET /api/v1/modules' do
    it 'works! (now write some real specs)' do
      get api_v1_modules_path
      expect(response).to have_http_status(200)
    end
  end
end
