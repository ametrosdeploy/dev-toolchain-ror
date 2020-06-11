# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Admin::V1::Sections', type: :request do
  describe 'GET /api/admin/v1/sections' do
    it 'works! (now write some real specs)' do
      get api_admin_v1_sections_path
      expect(response).to have_http_status(200)
    end
  end
end
