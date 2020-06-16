# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DialogicQuestions', type: :request do
  describe 'GET /dialogic_questions' do
    it 'works! (now write some real specs)' do
      get dialogic_questions_path
      expect(response).to have_http_status(200)
    end
  end
end
