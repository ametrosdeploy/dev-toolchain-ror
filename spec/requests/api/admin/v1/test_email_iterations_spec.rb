# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Admin::V1::TestEmailIterations', type: :request do
  describe 'GET /test_email_iterations' do
    it 'works! (now write some real specs)' do
      get test_email_iterations_path
      expect(response).to have_http_status(200)
    end
  end
end
