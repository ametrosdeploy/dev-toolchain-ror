# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::DialogicAnswers', type: :request do
  describe 'GET /dialogic_answers' do
    it 'works! (now write some real specs)' do
      get dialogic_answers_path
      expect(response).to have_http_status(200)
    end
  end
end
