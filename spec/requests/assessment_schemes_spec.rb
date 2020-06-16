# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AssessmentSchemes', type: :request do
  describe 'GET /assessment_schemes' do
    it 'works! (now write some real specs)' do
      get assessment_schemes_path
      expect(response).to have_http_status(200)
    end
  end
end
