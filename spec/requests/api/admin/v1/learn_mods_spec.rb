# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Admin::V1::LearnMods', type: :request do
  describe 'GET /api/admin/v1/learn_mods' do
    it 'works! (now write some real specs)' do
      get api_admin_v1_learn_mods_path
      expect(response).to have_http_status(200)
    end
  end
end
