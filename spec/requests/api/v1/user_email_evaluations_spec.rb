# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::UserEmailEvaluations', type: :request do
  describe 'GET /user_email_evaluations' do
    it 'works! (now write some real specs)' do
      get user_email_evaluations_path
      expect(response).to have_http_status(200)
    end
  end
end
