# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Admin::V1::DialogicTests', type: :request do
  describe 'GET /dialogic_tests' do
    it 'works! (now write some real specs)' do
      get dialogic_tests_path
      expect(response).to have_http_status(200)
    end
  end
end
