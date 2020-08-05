# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Admin::V1::QaConditions', type: :request do
  describe 'GET /qa_conditions' do
    it 'works! (now write some real specs)' do
      get qa_conditions_path
      expect(response).to have_http_status(200)
    end
  end
end
