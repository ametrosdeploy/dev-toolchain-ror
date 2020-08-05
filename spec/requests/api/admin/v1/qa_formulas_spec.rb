# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Admin::V1::QaFormulas', type: :request do
  describe 'GET /qa_formulas' do
    it 'works! (now write some real specs)' do
      get qa_formulas_path
      expect(response).to have_http_status(200)
    end
  end
end
