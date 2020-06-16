# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'QuizResponses', type: :request do
  describe 'GET /quiz_responses' do
    it 'works! (now write some real specs)' do
      get quiz_responses_path
      expect(response).to have_http_status(200)
    end
  end
end
